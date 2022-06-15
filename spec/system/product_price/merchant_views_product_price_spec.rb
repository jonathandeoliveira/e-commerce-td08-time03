require 'rails_helper'

describe "Mercador visualiza preço do produto" do  
  it 'a partir da tela inicial' do
    merchant = create(:merchant)
    product = create(:product_model)
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: 1.day.from_now, end_date: 30.day.from_now)
    second_price = create(:product_price, product_model: product, price: 280.0, start_date: 31.day.from_now, end_date: 60.day.from_now)
    

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on product.name

    expect(page).to have_content "Preço 1: R$ #{first_price.price}"
    expect(page).to have_content "Preço 2: R$ #{second_price.price}"
  end

  it 'e não existem preços cadastrados' do
    merchant = create(:merchant)
    product = create(:product_model)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on product.name

    expect(page).to have_content 'Não existem preços cadastrados'
    expect(page).to have_content 'Deseja cadastrar preço?'
    expect(page).to have_link 'Cadastrar preço'
  end
end
