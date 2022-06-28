require 'rails_helper'

describe 'Mercador visualiza pedidos' do
  it 'através da página inicial' do
    merchant = create(:merchant)
    customer = create(:customer, registration_number: '017.253.270-83')
    first_order = create(:order, customer: customer, address: customer.full_adress)
    second_order = create(:order, customer: customer, address: customer.full_adress)
    third_order = create(:order, customer: customer, address: customer.full_adress)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Pedidos cadastrados'

    expect(page).to have_content 'Pedidos'
    expect(page).to have_content 'Usuário'
    expect(page).to have_content 'Código do pedido'
    expect(page).to have_content 'Valor RB'
    expect(page).to have_content 'Status do pedido'
  end

  it 'e não existem pedidos cadastrados' do
    merchant = create(:merchant)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Pedidos cadastrados'

    expect(page).to have_content 'Não existem pedidos cadastrados'
  end
end