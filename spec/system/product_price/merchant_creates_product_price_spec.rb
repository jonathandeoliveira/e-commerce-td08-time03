require 'rails_helper'

describe 'Mercador cadastra preço para um produto' do
  it 'com sucesso' do
    merchant = create(:merchant)
    product = create(:product_model)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on product.name
    click_on 'Cadastrar preço'
    fill_in 'Preço', with: 300.99
    fill_in 'Data inicial', with: '15/06/22'
    fill_in 'Data final', with: '17/07/22'
    click_on 'Criar Preço do produto'

    expect(page).to have_content 'Preço cadastrado com sucesso.'
    expect(page).to have_content 'Preço 1: R$ 300,99'
    expect(page).to have_content 'Data inicial: 15/06/22'
    expect(page).to have_content 'Data final: 17/07/22'
  end
  
end