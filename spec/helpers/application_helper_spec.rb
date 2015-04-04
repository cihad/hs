require 'rails_helper'

RSpec.describe ApplicationHelper do
  
  describe '#full_title' do
    it 'when page_title argument is empty' do
      expect(helper.full_title "").to eq I18n.t('site.name')
    end

    it "when page_title argument isn't empty" do
      expect(helper.full_title("The Example Page")).to match /The Example Page/
      expect(helper.full_title("The Example Page")).to match /#{I18n.t('site.name')}/
    end
  end

  it "#title" do
    title = "Example Title"
    allow(helper).to receive(:provide).with(:title, title).and_return(result = double)
    expect(helper.title title).to eq result
  end

  it "#page_title" do
    title = "Example Title"    
    allow(helper).to receive(:render).with('page_header', title: title).and_return(rendered_html = double)
    expect(helper.page_title title).to eq rendered_html
  end

  it '#form_row' do
    label = "Attribute"
    block = ->{ "sample erb codes goes here" }
    allow(helper).to receive(:render).with(any_args()).and_return(rendered_html = double)
    expect(helper.form_row label, &block ).to eq rendered_html
  end

  it '#description' do
    description = "Sample description"
    allow(helper).to receive(:provide).with(:description, description).and_return(result = double)
    expect(helper.description description).to eq result
  end

  it '#list_nodes' do
    nodes = double
    allow(helper).to receive(:render).with('nodes/node_list', nodes: nodes).and_return(rendered_html = double)
    expect(helper.list_nodes nodes).to eq rendered_html
  end

  it '#content_form_for' do
    label = "Attribute"
    block = ->{ "sample erb codes goes here" }
    allow(helper).to receive(:render).with(any_args()).and_return(rendered_html = double)
    expect(helper.form_row label, &block ).to eq rendered_html
  end

  it '#new_node_path' do
    expect(helper.new_node_path :content).to eq(helper.new_content_path)
    expect(helper.new_node_path).to eq("/nodes/new")

  end

  it '#edit_node_path' do
    content = create :content
    node = content.node
    expect(helper.edit_node_path node).to eq(helper.edit_content_path content)
  end

  describe '#gravatar_url_for' do
    context "when rails environment isn't production" do
      it "gives gravatar url with gravatar's default image" do
        allow(Rails.env).to receive(:production?).and_return(false)
        expect(helper.gravatar_url_for "user@example.org").to match /d=mm/
        expect(helper.gravatar_url_for "user@example.org").to match /gravatar.com/
      end
    end

    context "when rails environment is production" do
      it "gives gravatar url with default user image" do
        allow(Rails.env).to receive(:production?).and_return(true)
        expect(helper.gravatar_url_for "user@example.org").to match /user.jpg/
        expect(helper.gravatar_url_for "user@example.org").to match /gravatar.com/
      end
    end
  end

  it "#submit_button" do
    f, button_text = double, double
    allow(helper).to receive(:render).with('submit_button', f: f, button_text: button_text).and_return(rendered_html = double)
    expect(helper.submit_button f: f, button_text: button_text).to eq rendered_html
  end
end