require 'rails_helper'

describe 'Usuário remove item do carrinho' do
  it 'com sucesso' do
    customer = create(:customer)
    first_product = create(:product_model, status: 'enabled')
    second_product = create(:product_model, status: 'enabled')
    first_item = create(:product_item, customer: customer, product_model: first_product, quantity: 6)
    second_item = create(:product_item, customer: customer, product_model: second_product, quantity: 2)

    login_as(customer, scope: :customer)
    delete "/customers/#{customer.id}/product_items/#{second_item.id}"

    expect(response).to redirect_to "/customers/#{customer.id}/product_items"
    expect(response).to_not include second_item.product_model.name
  end

  it 'e esvazia carrinho' do
    customer = create(:customer)
    first_product = create(:product_model, status: 'enabled')
    second_product = create(:product_model, status: 'enabled')
    first_item = create(:product_item, customer: customer, product_model: first_product, quantity: 1)
    second_item = create(:product_item, customer: customer, product_model: second_product, quantity: 5)

    login_as(customer, scope: :customer)
    delete "/customers/#{customer.id}/product_items/remove_all"

    expect(response).to redirect_to "/customers/#{customer.id}/product_items"
    expect(ProductItem.last).to eq nil
  end
end