require 'rails_helper'

describe 'Cliente remove item do carrinho' do
  it 'com sucesso' do
    customer = create(:customer)
    first_product = create(:product_model, name: 'Notebook')
    second_product = create(:product_model, name: 'Liquidificador')
    create(:product_price, product_model: first_product, price: 300.99, start_date: Date.today,
                           end_date: 100.day.from_now)
    create(:product_price, product_model: second_product, price: 500.99,
                           start_date: Date.today, end_date: 100.day.from_now)
    first_product.enabled!
    second_product.enabled!

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Notebook'
    fill_in 'Quantidade', with: '2'
    click_on 'Adicionar ao carrinho'

    expect(page).to have_content 'Notebook adicionado ao carrinho.'
    expect(page).to have_content 'Produto'
    expect(page).to have_content 'Notebook'
    expect(page).to have_content 'Quantidade'
    expect(page).to have_content '2'
  end
end
