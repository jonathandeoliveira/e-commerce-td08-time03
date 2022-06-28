require 'rails_helper'

describe 'Usuário vê detalhes de um pedido' do
  xit 'a partir da página de pedidos' do
    customer = create(:customer, email: 'mondser@energy.com', registration_number: '112.454.555-28')
    first_product = create(:product_model, status: 'enabled')
    second_product = create(:product_model, status: 'enabled')
    first_price = create(:product_price, product_model: first_product, price: 300.99, start_date: Date.today, end_date: 100.day.from_now)
    second_price = create(:product_price, product_model: second_product, price: 500.99, start_date: Date.today, end_date: 100.day.from_now)
    first_product_item = create(:product_item)
    second_product_item = create(:product_item)
    first_order = create(:order, customer: customer, address: customer.full_adress, product_items: first_product_item)
    second_order = create(:order, customer: customer, address: customer.full_adress, product_items: second_product_item)
    first_product_item.order_id = first_order.id
    second_product_item.order_id = second_order.id

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meus pedidos'
    click_on first_order.code

    expect(page).to have_content "Pedido #{first_order.code}"
    expect(page).to have_content 'Produto'
    expect(page).to have_content 'Quantidade'
    expect(page).to have_content 'Valor unitário'
    expect(page).to have_content 'Valor total'
    expect(page).to have_content first_order.customer.product_items[0].product_model.name
    expect(page).to have_content second_order.customer.product_items[0].product_model.name
  end
end