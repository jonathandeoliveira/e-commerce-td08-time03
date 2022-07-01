require 'rails_helper'

describe 'Mercador muda visibilidade de um produto' do
  it 'a partir da página inicial' do
    merchant = create(:merchant)
    product = create(:product_model, status: 0)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content product.name
    expect(page).to have_button  'Desativar'
    expect(page).not_to have_button 'Ativar'
  end

  it 'e desabilita-o' do
    merchant = create(:merchant)
    product = create(:product_model, status: 0)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on 'Desativar'

    expect(page).to have_button 'Ativar'
    expect(page).not_to have_button 'Desativar'
    expect(page).to have_content 'Produto desativado com sucesso'
    expect(page).to have_content 'Situação'
    expect(page).to have_content 'Fora de estoque'
    product = product.reload
    result = product.status
    expect(result).to eq 'disabled'
  end

  it 'e ativa-o' do
    merchant = create(:merchant)
    product = create(:product_model)
    first_price = create(:product_price, price: 300.99, start_date: Date.today, end_date: 30.day.from_now, product_model: product)
    second_price = create(:product_price, price: 329.00, start_date: 31.day.from_now, end_date: 61.day.from_now, product_model: product)
    third_price = create(:product_price, price: 280.00, start_date: 62.day.from_now, end_date: 92.day.from_now, product_model: product)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on 'Ativar'

    expect(page).not_to have_button 'Ativar'
    expect(page).to have_button 'Desativar'
    expect(page).to have_content 'Produto ativado com sucesso'
    expect(page).to have_content 'Situação'
    expect(page).to have_content 'Em estoque'
    product = product.reload
    result = product.status
    expect(result).to eq 'enabled'
  end

  it 'e ativa-o sem sucesso, pois não há intervalo de preços cadastrados de no mínimo 90 dias' do
    merchant = create(:merchant)
    product = create(:product_model)
    first_price = create(:product_price, price: 300.99, start_date: Date.today, end_date: 30.day.from_now, product_model: product)
    second_price = create(:product_price, price: 329.00, start_date: 31.day.from_now, end_date: 61.day.from_now, product_model: product)
    total_days = ((first_price.end_date - first_price.start_date) + (second_price.end_date - second_price.start_date))

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on 'Ativar'

    expect(page).to have_content "Produto com #{total_days.round} dias cadastrados"
    expect(page).to have_content 'Produto não pode ser ativado: Necessário mínimo de 90 dias de preços cadastrados.' 
    product = product.reload
    result = product.status
    expect(result).to eq 'disabled'
  end
end
