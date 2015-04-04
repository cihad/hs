require 'rails_helper'

RSpec.describe SitemapController, type: :controller do
  
  it "#sitemap" do
    get :sitemap, format: :xml
    expect(response).to be_success
  end

end