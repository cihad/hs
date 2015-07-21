ActionMailer::Base.default_url_options = { host: Rails.application.secrets.host }
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:              Rails.application.secrets.smtp["address"],
  port:                 Rails.application.secrets.smtp["port"],
  domain:               Rails.application.secrets.smtp["domain"],
  authentication:       :login,
  enable_starttls_auto: true,
  user_name:            Rails.application.secrets.smtp["username"],
  password:             Rails.application.secrets.smtp["password"]
}