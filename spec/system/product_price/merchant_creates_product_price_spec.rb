require 'rails_helper'

describe 'Mercador cadastra preço para um produto' do
  it 'se estiver autenticado' do
    product = create(:product_model)

    visit new_product_model_product_price_path(product)
    
    expect(current_path).not_to eq new_product_model_product_price_path(product)
    expect(current_path).to eq new_merchant_session_path
  end

  it 'com sucesso' do
    merchant = create(:merchant)
    product = create(:product_model)
    start_date = Date.today
    end_date = start_date + 10
    
    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on product.name
    click_on 'Cadastrar preço'
    fill_in 'Preço', with: 300.99
    fill_in 'Data inicial', with: start_date
    fill_in 'Data final', with: end_date
    click_on 'Criar Preço do produto'
    
    expect(page).to have_content 'Preço cadastrado com sucesso.'
    expect(page).to have_content 'Preço 1: R$ 300,99'
    expect(page).to have_content "Data inicial: #{I18n.l(start_date)}"
    expect(page).to have_content "Data final: #{I18n.l(end_date)}"
  end

  it 'sem sucesso, pois campos obrigatórios não foram preenchidos' do
    merchant = create(:merchant)
    product = create(:product_model)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on product.name
    click_on 'Cadastrar preço'
    fill_in 'Preço', with: ''
    fill_in 'Data inicial', with: ''
    fill_in 'Data final', with: ''
    click_on 'Criar Preço do produto'

    expect(page).to have_content 'Preço não pode ser cadastrado.'
    expect(page).to have_content 'Preço não pode ficar em branco'
    expect(page).to have_content 'Data inicial não pode ficar em branco'
    expect(page).to have_content 'Data final não pode ficar em branco'
  end

  it 'sem sucesso, pois data inicial é igual a final' do
    merchant = create(:merchant)
    product = create(:product_model)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on product.name
    click_on 'Cadastrar preço'
    fill_in 'Preço', with: 300.99
    fill_in 'Data inicial', with: Date.today
    fill_in 'Data final', with: Date.today
    click_on 'Criar Preço do produto'

    expect(page).to have_content 'Preço não pode ser cadastrado.'
    expect(page).to have_content 'Data inicial e data final não podem ser iguais.'
  end

  it 'sem sucesso, pois datas estão no passado' do
    merchant = create(:merchant)
    product = create(:product_model)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on product.name
    click_on 'Cadastrar preço'
    fill_in 'Preço', with: 300.99
    fill_in 'Data inicial', with: 5.day.ago
    fill_in 'Data final', with: 5.day.ago
    click_on 'Criar Preço do produto'

    expect(page).to have_content 'Preço não pode ser cadastrado.'
    expect(page).to have_content 'Data inicial não pode ser no passado.'
    expect(page).to have_content 'Data final não pode ser no passado.'
  end
  
  it 'sem sucesso, pois data final é anterior à data inicial' do
    merchant = create(:merchant)
    product = create(:product_model)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on product.name
    click_on 'Cadastrar preço'
    fill_in 'Preço', with: 300.99
    fill_in 'Data inicial', with: 1.day.from_now
    fill_in 'Data final', with: 1.day.ago
    click_on 'Criar Preço do produto'

    expect(page).to have_content 'Preço não pode ser cadastrado.'
    expect(page).to have_content 'Data final não pode ser anterior à data inicial.'
  end
end