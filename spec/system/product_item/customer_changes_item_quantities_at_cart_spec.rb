require 'rails_helper'

describe 'Cliente altera quantidade de itens no carrinho' do
  it 'adicionando com sucesso, a partir da página do carrinho' do
    customer = create(:customer)
    product = create(:product_model, name: 'Notebook', status: 'enabled')
    create(:product_price, product_model: product, price: 300.99, start_date: Date.today, end_date: 100.day.from_now)
    item = create(:product_item, customer: customer, product_model: product)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'
    click_on '+'

    expect(ProductItem.last.quantity).to eq 2
    expect(page).to have_content 'Unidade adicionada com sucesso'
  end

  it 'removendo com sucesso, a partir da página do carrinho' do
    customer = create(:customer)
    product = create(:product_model, name: 'Notebook', status: 'enabled')
    create(:product_price, product_model: product, price: 300.99, start_date: Date.today, end_date: 100.day.from_now)
    item = create(:product_item, customer: customer, product_model: product, quantity: 5)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'
    click_on '-'

    expect(ProductItem.last.quantity).to eq 4
    expect(page).to have_content 'Unidade removida com sucesso'
  end

  it 'e remove todos os itens' do
    customer = create(:customer)
    first_product = create(:product_model, name: 'Notebook', status: 'enabled')
    second_product = create(:product_model, name: 'TV', status: 'enabled')
    third_product = create(:product_model, name: 'Chaveiro', status: 'enabled')
    create(:product_price, product_model: first_product, price: 300.99, start_date: Date.today, end_date: 100.day.from_now)
    create(:product_price, product_model: second_product, price: 1400.99, start_date: Date.today, end_date: 100.day.from_now)
    create(:product_price, product_model: third_product, price: 14.99, start_date: Date.today, end_date: 100.day.from_now)
    first_item = create(:product_item, customer: customer, product_model: first_product, quantity: 1)
    second_item = create(:product_item, customer: customer, product_model: second_product, quantity: 2)
    third_item = create(:product_item, customer: customer, product_model: third_product, quantity: 9)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'
    click_on 'Limpar carrinho'

    expect(page).to have_content 'Seu carrinho está vazio'
  end
end