require 'rails_helper'

describe 'Usuário finaliza compra' do
  it 'a partir do carrinho de compras' do
    customer = create(:customer, balance: 10000)
    product = create(:product_model, name: 'Notebook', status: 'enabled')
    second_product = create(:product_model, name: 'TV', status: 'enabled')
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: Date.today, end_date: 100.day.from_now)
    second_price = create(:product_price, product_model: second_product, price: 500.99, start_date: Date.today, end_date: 100.day.from_now)
    first_item = create(:product_item, customer: customer, product_model: product)
    second_item = create(:product_item, customer: customer, product_model: second_product)
    allow(SecureRandom).to receive(:alphanumeric).and_return('QUINZCARACTERES')

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'
    click_on 'Finalizar pedido'
    click_on 'Confirmar'

    expect(page).to have_content 'Compra realizada com sucesso'
    expect(page).to have_content 'Código do pedido'
    expect(page).to have_content 'QUINZCARACTERES'
    expect(page).to have_content 'Status do pedido'
    expect(page).to have_content 'Pendente de pagamento'
  end
end