require 'rails_helper'

describe 'Mercador cria produto' do
  it 'a partir da tela inicial' do
    visit root_path

    expect(page).to have_link 'Criar Produto'
  end

  it 'a partir do formulário' do
    visit root_path
    click_on 'Criar Produto'
    expect(page).to have_content 'Informe as caracteristicas do produto'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Marca'
    expect(page).to have_field 'Modelo'
    expect(page).to have_field 'SKU'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Altura'
    expect(page).to have_field 'Largura'
    expect(page).to have_field 'Comprimento'
    expect(page).to have_field 'Peso'
  end

  it 'com sucesso' do
    visit root_path
    within('nav') do
      click_on 'Criar Produto'
    end
    fill_in 'Nome', with: 'Notebook'
    fill_in 'Marca', with: 'Dell'
    fill_in 'Modelo', with: 'Inspiron 15'
    fill_in 'SKU', with: 'DELL948297'
    fill_in 'Descrição', with: 'Notebook 15 processador intel i7'
    fill_in 'Altura', with: '0.3'
    fill_in 'Largura', with: '0.45'
    fill_in 'Comprimento', with: '0.15'
    fill_in 'Peso', with: '6'
    click_on 'Cadastrar'

    expect(page).to have_content 'Produto cadastrado com sucesso'
    expect(page).to have_content 'Produto: Notebook Dell Inspiron 15'
    expect(page).to have_content 'SKU: DELL948297'
    expect(page).to have_content 'Descrição: Notebook 15 processador intel i7'
    expect(page).to have_content 'Dimensões: 0.3m x 0.45m x 0.15m'
    expect(page).to have_content 'Peso: 6.0kg'
  end

  it 'com dados incompletos' do
    visit root_path
    within('nav') do
      click_on 'Criar Produto'
    end
    fill_in 'Nome', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Modelo', with: ''
    fill_in 'SKU', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Comprimento', with: ''
    fill_in 'Peso', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Marca não pode ficar em branco'
    expect(page).to have_content 'SKU não pode ficar em branco'
    expect(page).to have_content 'Modelo não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
    expect(page).to have_content 'Comprimento não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
  end


  
end
