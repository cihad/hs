require 'rails_helper'
require 'policies/concerns/content_policy_shared_examples'

RSpec.describe ProductPolicy do
  
  it_behaves_like "content_policy"

  let(:current_user) { double }
  let(:content) { double }
  subject { described_class.new current_user, content }

  context "#permitted_attributes" do

    let(:low_level_attributes) do
      [
        :title,
        :body,
        node_attributes: [:id, :tag_list]
      ]
    end

    let(:administrative_attributes) do
      low_level_attributes[-1][:node_attributes] << :status
      low_level_attributes
    end

    it "when current_user isn't manager" do
      allow(current_user).to receive(:manager?).and_return(false)
      expect(subject.permitted_attributes).to eq low_level_attributes
    end
    
    it "when current_user is manager" do      
      allow(current_user).to receive(:manager?).and_return(true)
      expect(subject.permitted_attributes).to eq administrative_attributes
    end

  end

end