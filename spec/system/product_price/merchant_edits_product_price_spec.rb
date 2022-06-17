require 'rails_helper'

describe 'Mercador edita preço de produto' do
  it 'com sucesso' do
    merchant = create(:merchant)
    product = create(:product_model)
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: 1.day.from_now, end_date: 30.day.from_now)
    second_price = create(:product_price, product_model: product, price: 280.0, start_date: 31.day.from_now, end_date: 60.day.from_now)
    third_price = create(:product_price, product_model: product, price: 320.0, start_date: 62.day.from_now, end_date: 92.day.from_now)
    start_date = Date.today
    end_date = start_date + 10

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on product.name
    first(:link, 'Editar preço').click
    fill_in 'Preço', with: 280
    fill_in 'Data inicial', with: start_date
    fill_in 'Data final', with: end_date
    click_on 'Atualizar Preço do produto'

    expect(page).to have_content 'Edição de preço realizada com sucesso'
    expect(page).to have_content 'Preço 1: R$ 280,00'
    expect(page).to have_content 'Preço 2: R$ 280,00'
    expect(page).to have_content 'Preço 3: R$ 320,00'
  end
end