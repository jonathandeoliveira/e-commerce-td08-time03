require 'rails_helper'

describe 'Cliente remove item do carrinho' do
  it 'sem sucesso pois não está autenticado' do
    visit root_path

    expect(page).not_to have_content 'Meu carrinho'
  end

  it 'com sucesso' do
    customer = create(:customer)
    product = create(:product_model, name: 'Notebook')
    second_product = create(:product_model, name: 'TV')
    create(:product_price, product_model: product, price: 300.99, start_date: Date.today,
                           end_date: 100.day.from_now)
    create(:product_price, product_model: second_product, price: 500.99,
                           start_date: Date.today, end_date: 100.day.from_now)
    create(:product_item, customer:, product_model: product)
    create(:product_item, customer:, product_model: second_product)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'
    first(:button, 'Remover').click

    expect(page).to have_content 'Item removido com sucesso.'
    expect(page).not_to have_content 'Notebook'
  end
end
