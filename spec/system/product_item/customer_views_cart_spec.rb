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
    first_product = create(:product_model, name: 'Notebook')
    first_product_item = create(:product_item, customer: customer, product_model: first_product)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'

    expect(page).to have_content 'Carrinho de compras'
    expect(page).to have_content 'Produtos selecionados:'
    expect(page).to have_content first_product_item.product_model.name
    expect(page).to have_content "Preço: #{first_product_item.product_model.price}"
    expect(page).to have_content "Quantidade: #{first_product_item.quantity} item"
  end
end
