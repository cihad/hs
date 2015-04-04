require 'rails_helper'

RSpec.describe NewIdeasController, type: :controller do
  
  NewIdeasController.action_methods.each do |method|
    it "renders #{method} template" do
      get method
      expect(response).to render_template method      
    end
  end

end