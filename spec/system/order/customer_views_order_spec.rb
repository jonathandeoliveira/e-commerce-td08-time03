require 'rails_helper'

describe 'Usuário vê detalhes de um pedido' do
  it 'a partir da página de pedidos' do
    customer = create(:customer)
    # first_product = create(:product_model, status: 'enabled')
    # second_product = create(:product_model, status: 'enabled')
    # first_price = create(:product_price, product_model: first_product, price: 300.99, start_date: Date.today, end_date: 100.day.from_now)
    # second_price = create(:product_price, product_model: second_product, price: 500.99, start_date: Date.today, end_date: 100.day.from_now)
    first_order = create(:order, customer: customer, address: customer.full_adress)
    second_order = create(:order, customer: customer, address: customer.full_adress)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meus pedidos'
    click_on first_order.code
    binding.pry

    expect(page).to have_content "Pedido #{first_order.code}"
    expect(page).to have_content 'Produto'
    expect(page).to have_content 'Quantidade'
    expect(page).to have_content 'Valor unitário'
    expect(page).to have_content 'Valor total'
    expect(page).to have_content first_order.customer.product_items[0].product_model.name
    expect(page).to have_content second_order.customer.product_items[0].product_model.name
  end
end