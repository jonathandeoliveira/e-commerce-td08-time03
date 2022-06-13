require 'rails_helper'

describe 'Mercador acessa página principal de produtos' do
  it 'devendo estar autenticado' do
    visit root_path

    expect(page).not_to have_link 'Produtos'
  end

  it 'através da página inicial' do
    merchant = create(:merchant)
    produto = create(:product_model)

    login_as(merchant)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Produtos cadastrados'
    expect(page).to have_content 'Produto: Notebook'
    expect(page).to have_content 'Marca: Dell'
    expect(page).to have_content 'Modelo: Inspiron 15'
    expect(page).to have_content 'SKU: DELL948297'
  end

  it 'e não existem produtos cadastrados' do
    merchant = create(:merchant)

    login_as(merchant)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Não existem produtos cadastrados'
  end

  it 'e visualiza detalhes de um produto' do
    merchant = create(:merchant)
    produto = create(:product_model)

    login_as(merchant)
    visit root_path
    click_on 'Produtos'
    click_on 'Notebook'

    expect(current_path).to eq product_model_path(produto) 
    expect(page).to have_content 'Produto: Notebook Dell Inspiron 15'
    expect(page).to have_content 'SKU: DELL948297'
    expect(page).to have_content 'Peso: 6.0kg'
  end

  it 'e volta para página inicial' do
    merchant = create(:merchant)

    login_as(merchant)
    visit root_path
    click_on 'Produtos'
    click_on 'Página Inicial'

    expect(current_path).to eq root_path
  end
end