require 'rails_helper'

describe 'mercador edita categorias cadastradas' do
  it 'se estiver autenticado' do
    categories = create_list(:random_category, 3)
    first_category = categories[0]

    visit edit_category_path(first_category)

    expect(current_path).to eq new_merchant_session_path
  end

  it 'a partir da tela de categorias' do
    merchant = create(:merchant)
    categories = create_list(:random_category, 3)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Categorias'
    first(:link, 'Editar Categoria').click

    expect(page).to have_content "Edição da Categoria: #{categories[0].name}"
    expect(page).to have_field 'Nome', with: categories[0].name
    expect(page).to have_button 'Atualizar'
  end

  it 'com sucesso' do
    merchant = create(:merchant)
    categories = create_list(:random_category, 3)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Categorias'
    first(:link, 'Editar Categoria').click
    first_name = categories[0].name
    fill_in 'Nome', with: 'Eletrônicos'
    click_on 'Atualizar'

    expect(page).to have_content 'Categoria atualizada com sucesso.'
    expect(page).not_to have_content "Nome: #{first_name}"
    expect(page).to have_content 'Nome: Eletrônicos'
  end

  it 'sem sucesso' do
    merchant = create(:merchant)
    categories = create_list(:random_category, 3)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Categorias'
    first(:link, 'Editar Categoria').click
    fill_in 'Nome', with: ''
    click_on 'Atualizar'

    expect(page).to have_content 'Falha ao atualizar categoria.'
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
end
