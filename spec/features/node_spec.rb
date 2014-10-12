require 'rails_helper'

RSpec.describe "Node process", type: :feature do
  
  it "creates a new node" do
    visit new_node_path
    fill_in "node_title", with: "Dynamic Branding Facilitator"
    fill_in "node_tldr",  with: "Animi tempora ad magni provident enim ex est."
    fill_in "node_body",  with: "Aut iure blanditiis impedit earum. Porro vel molestias temporibus. Voluptatem ea et aut quaerat illum est.\n\nnPorro aliquid neque. Inventore nemo dolores non quia. Voluptatem recusandae vero nesciunt exercitationem sunt. Rerum laboriosam labore. Velit aliquid provident suscipit dolorem qui.\n\nVoluptatum earum exercitationem et optio. Autem suscipit aut impedit quia et. Possimus ut aut ipsam."
    click_on I18n.t('helpers.submit.create')
    expect(page).to have_content "Dynamic Branding Facilitator"
  end

end