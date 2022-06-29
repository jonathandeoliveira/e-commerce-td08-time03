require 'rails_helper'

describe 'Mercador visualiza detalhes de um pedido' do
  it 'com sucesso' do
    merchant = create(:merchant)
    customer = create(:customer, registration_number: '017.253.270-83')
    first_order = create(:order, customer: customer, address: customer.full_adress)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Pedidos cadastrados'
    click_on first_order.code

    expect(page).to have_content "Detalhes do pedido #{first_order.code}"
    expect(page).to have_content "Nome do cliente: #{first_order.customer.name}"
    expect(page).to have_content "E-mail do cliente: #{first_order.customer.email}"
    expect(page).to have_content "Produto"
    expect(page).to have_content "Detalhes do pedido #{first_order.code}"
  end
end