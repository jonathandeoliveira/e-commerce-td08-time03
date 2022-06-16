require 'rails_helper'

describe 'Mercador cadastra nova categoria' do
  it 'e precisa estar autenticado' do
    visit new_category_path
    expect(current_path).to eq new_merchant_session_path
  end

  it 'a partir da tela inicial' do
    merchant = create(:merchant)
    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Categorias'
    click_on 'Nova Categoria'

    expect(page).to have_content 'Nova Categoria'
    expect(page).to have_field 'Nome'
    expect(page).to have_button 'Criar Categoria'
  end

  it 'com sucesso' do
    merchant = create(:merchant)
    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Categorias'
    click_on 'Nova Categoria'

    fill_in 'Nome', with: 'Eletrônicos'
    click_on 'Criar Categoria'

    expect(current_path).to eq categories_path
    expect(page).to have_content 'Categoria criada com sucesso'
    expect(page).to have_content 'Nome: Eletrônicos'
    expect(page).to have_content 'Situação: Ativa'
  end

  it 'sem sucesso' do
    merchant = create(:merchant)
    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Categorias'
    click_on 'Nova Categoria'

    fill_in 'Nome', with: ''
    click_on 'Criar Categoria'

    expect(page).to have_content 'Falha ao criar categoria'
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
end
