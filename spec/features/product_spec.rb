require "rails_helper"

feature "Product" do
  
  let(:user) { create :authenticated }

  scenario "User creates a new product" do
    login user
    visit "/nodes/new/products"

    fill_in "product_title", with: "Example Title"
    fill_in "product_body", with: "Example Body"

    click_button I18n.t('helpers.submit.create')

    expect(page).to have_content "Example Title"
    expect(page).to have_content "Example Body"
  end

  scenario "User edits the existing content" do
    product = create :product, author: user
    login user

    visit node_path(product.node)

    within "#node_#{product.node.id}" do
      click_link I18n.t('common.edit')
    end

    fill_in "product_title", with: "CHANGE TITLE!!!"
    click_button I18n.t('helpers.submit.update')
    expect(page).to have_content 'CHANGE TITLE!!!'
  end

  pending "shows similar contents" do
    product1 = create :product, title: "Example Title"
    product2 = create :product, title: "Example Content"
    product3 = create :product, title: "Example Article"

    visit node_path(product1.node)

    expect(page).to have_content "Example Title"
    expect(page).to have_content "Example Content"
    expect(page).to have_content "Example Article"
  end

end