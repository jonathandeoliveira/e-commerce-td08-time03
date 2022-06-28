require 'rails_helper'

describe 'Cliente acessa carrinho' do
  it 'sem sucesso pois não está autenticado' do
    visit root_path

    expect(page).not_to have_content 'Meu carrinho'
  end

  it 'e está vazio' do
    customer = create(:customer)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'

    expect(page).to have_content 'Meu carrinho'
    expect(page).to have_content customer.email
    expect(page).to have_content 'Seu carrinho está vazio'
  end

  it 'e vê os produtos adicionados' do
    customer = create(:customer)
    product = create(:product_model, name: 'Notebook', status: 'enabled')
    second_product = create(:product_model, name: 'TV', status: 'enabled')
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: Date.today, end_date: 100.day.from_now)
    second_price = create(:product_price, product_model: second_product, price: 500.99, start_date: Date.today, end_date: 100.day.from_now)
    product_item = create(:product_item, customer: customer, product_model: product)
    second_item = create(:product_item, customer: customer, product_model: second_product)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'

    expect(page).to have_content 'Carrinho de compras'
    expect(page).to have_content 'Produtos selecionados:'
    expect(page).to have_content 'Produto'
    expect(page).to have_content 'Quantidade'
    expect(page).to have_content 'Preço unitário'
    expect(page).to have_content 'Preço total'
    expect(page).to have_content product_item.product_model.name
    expect(page).to have_content second_item.product_model.name
    expect(page).to have_content product.current_price.round(2)
    expect(page).to have_content second_product.current_price.round(2)
    expect(page).to have_content "#{product_item.quantity}"
    expect(page).to have_content "#{second_item.quantity}"
  end
end
