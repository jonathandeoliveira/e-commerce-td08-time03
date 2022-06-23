require 'rails_helper'
include ActionView::Helpers::NumberHelper

describe 'Usuário vê produtos do ecommerce' do

  it 'na página principal' do
    product1 = create(:product_model, status: :enabled)
    product2 = create(:product_model, status: :enabled)
    price1 = create(:product_price, product_model: product1)
    price2 = create(:product_price, price: 215, product_model: product2)

    visit root_path

    expect(page).to have_content 'Nossos produtos:'
    expect(page).to have_content product1.name
    expect(page).to have_content product2.name
    expect(page).to have_content number_to_currency(price1.price)
    expect(page).to have_content number_to_currency(price2.price)
  end

  it 'e não vê produtos cadastrados' do
    visit root_path

    expect(page).to have_content 'Ainda não existem produtos disponíveis'
  end

  it 'e não vê produtos desabilitados' do
    product1 = create(:product_model, status: :disabled)
    product2 = create(:product_model, status: :enabled)
    price1 = create(:product_price, product_model: product1)
    price2 = create(:product_price, price: 215, product_model: product2)

    visit root_path

    expect(page).not_to have_content product1.name
    expect(page).not_to have_content number_to_currency(price1.price)
    expect(page).to have_content product2.name
    expect(page).to have_content number_to_currency(price2.price)
  end

  it 'e vê o preço na data correta' do
    product1 = create(:product_model, status: :enabled)
    product2 = create(:product_model, status: :enabled)
    price1 = create(:product_price, product_model: product1)
    price2 = create(:product_price, price: 215, product_model: product2)
    price3 = create(:product_price, price: 300, product_model: product1, start_date: 4.months.from_now, end_date: 5.months.from_now)
    price4 = create(:product_price, price: 400, product_model: product2, start_date: 4.months.from_now, end_date: 5.months.from_now)

    visit root_path

    expect(page).to have_content 'Nossos produtos:'
    expect(page).to have_content product1.name
    expect(page).to have_content product2.name
    expect(page).to have_content number_to_currency(price1.price)
    expect(page).to have_content number_to_currency(price2.price)
    expect(page).not_to have_content number_to_currency(price3.price)
    expect(page).not_to have_content number_to_currency(price4.price)
  end
end