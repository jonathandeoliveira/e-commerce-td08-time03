require 'rails_helper'

describe 'Cliente adiciona item no carrinho' do  
  it 'e não está autenticado' do
    first_product = create(:product_model, name: 'Notebook')
    second_product = create(:product_model, name: 'Liquidificador')
    create(:product_price, product_model: first_product, price: 300.99, start_date: Date.today,
                           end_date: 100.day.from_now)
    create(:product_price, product_model: second_product, price: 500.99,
                           start_date: Date.today, end_date: 100.day.from_now)
    first_product.enabled!
    second_product.enabled!

    visit root_path
    first(:link, 'Ver').click
    click_on 'Adicionar ao carrinho'

    expect(current_path).to eq new_customer_session_path
  end

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
    first(:link, 'Ver').click
    fill_in 'Quantidade', with: '2'
    click_on 'Adicionar ao carrinho'

    expect(page).to have_content "#{first_product.name} adicionado ao carrinho."
    expect(page).to have_content 'Produto'
    expect(page).to have_content "#{first_product.name}"
    expect(page).to have_content 'Quantidade'
    expect(page).to have_content '2'
  end

  it 'sem sucesso com quantidade menor que 1' do
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
    first(:link, 'Ver').click
    fill_in 'Quantidade', with: '0'
    click_on 'Adicionar ao carrinho'

    expect(page).to have_content 'A quantidade deve ser maior do que 0'
    expect(current_path).to eq product_detail_product_model_path(first_product)
  end
end
