require 'rails_helper'

describe 'Usuário visualiza pedidos realizados' do
  it 'com sucesso' do
    customer = create(:customer)
    first_order = create(:order, customer: customer, address: customer.full_adress)
    second_order = create(:order, customer: customer, address: customer.full_adress)
    third_order = create(:order, customer: customer, address: customer.full_adress)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meus pedidos'

    expect(page).to have_content 'Meus pedidos'
    expect(page).to have_link first_order.code
    expect(page).to have_link second_order.code
    expect(page).to have_link third_order.code
  end

  it 'e não existem pedidos realizados' do
    customer = create(:customer)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meus pedidos'

    expect(page).to have_content 'Não existem pedidos realizados'
  end
end