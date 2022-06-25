require 'rails_helper'

describe 'Usuário altera quantidade de itens no carrinho' do
  it 'com sucesso adicionando quantidade' do
    customer = create(:customer)
    product = create(:product_model, status: 'enabled')
    item = create(:product_item, customer: customer, product_model: product, quantity: 6)

    login_as(customer, scope: :customer)
    patch "/customers/#{customer.id}/product_items/#{item.id}/sum_quantity"

    expect(response).to redirect_to "/customers/#{customer.id}/product_items"
    item.reload
    expect(item.quantity).to eq 7
  end

  it 'com sucesso diminuindo quantidade' do
    customer = create(:customer)
    product = create(:product_model, status: 'enabled')
    item = create(:product_item, customer: customer, product_model: product, quantity: 10)

    login_as(customer, scope: :customer)
    patch "/customers/#{customer.id}/product_items/#{item.id}/reduce_quantity"

    expect(response).to redirect_to "/customers/#{customer.id}/product_items"
    item.reload
    expect(item.quantity).to eq 9
  end
end