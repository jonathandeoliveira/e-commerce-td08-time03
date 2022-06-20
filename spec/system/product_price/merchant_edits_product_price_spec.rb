require 'rails_helper'

describe 'Mercador edita preço de produto' do
  it 'e deve estar autenticado' do
    product = create(:product_model)
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: 1.day.from_now, end_date: 30.day.from_now)
    second_price = create(:product_price, product_model: product, price: 280.0, start_date: 31.day.from_now, end_date: 60.day.from_now)
    third_price = create(:product_price, product_model: product, price: 320.0, start_date: 62.day.from_now, end_date: 92.day.from_now)

    visit edit_product_model_product_price_path(product, first_price)

    expect(current_path).not_to eq edit_product_model_product_price_path(product, first_price)
    expect(current_path).to eq new_merchant_session_path
  end

  it 'com sucesso' do
    merchant = create(:merchant)
    product = create(:product_model)
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: 10.day.from_now, end_date: 30.day.from_now)
    second_price = create(:product_price, product_model: product, price: 280.0, start_date: 31.day.from_now, end_date: 60.day.from_now)
    third_price = create(:product_price, product_model: product, price: 320.0, start_date: 62.day.from_now, end_date: 92.day.from_now)
    start_date = Date.today
    end_date = start_date + 8

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on product.name
    first(:link, 'Editar preço').click
    fill_in 'Preço', with: 280
    fill_in 'Data inicial', with: start_date
    fill_in 'Data final', with: end_date
    click_on 'Atualizar Preço do produto'

    expect(page).to have_content 'Edição de preço realizada com sucesso'
    expect(page).to have_content 'Preço 1: R$ 280,00'
    expect(page).to have_content 'Preço 2: R$ 280,00'
    expect(page).to have_content 'Preço 3: R$ 320,00'
  end

  it 'com dados incompletos' do
    merchant = create(:merchant)
    product = create(:product_model)
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: 1.day.from_now, end_date: 30.day.from_now)
    second_price = create(:product_price, product_model: product, price: 280.0, start_date: 31.day.from_now, end_date: 60.day.from_now)
    third_price = create(:product_price, product_model: product, price: 320.0, start_date: 62.day.from_now, end_date: 92.day.from_now)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on product.name
    first(:link, 'Editar preço').click
    fill_in 'Preço', with: 280
    fill_in 'Data inicial', with: ''
    fill_in 'Data final', with: ''
    click_on 'Atualizar Preço do produto'

    expect(page).to have_content 'Falha ao atualizar preço do produto.'
    expect(page).to have_content 'Data inicial não pode ficar em branco'
    expect(page).to have_content 'Data final não pode ficar em branco'
  end

  it 'sem sucesso, pois intervalo de datas já existe' do
    merchant = create(:merchant)
    product = create(:product_model)
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: 1.day.from_now, end_date: 30.day.from_now)
    second_price = create(:product_price, product_model: product, price: 280.0, start_date: 31.day.from_now, end_date: 60.day.from_now)
    third_price = create(:product_price, product_model: product, price: 320.0, start_date: 62.day.from_now, end_date: 92.day.from_now)
    start_date = Date.today
    end_date = start_date + 40

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on product.name
    first(:link, 'Editar preço').click
    fill_in 'Preço', with: 280
    fill_in 'Data inicial', with: start_date
    fill_in 'Data final', with: end_date
    click_on 'Atualizar Preço do produto'

    expect(page).to have_content 'Falha ao atualizar preço do produto.'
    expect(page).to have_content 'Preço não pode ser cadastrado, pois está incluso em intervalo de datas já existentes'
  end
end