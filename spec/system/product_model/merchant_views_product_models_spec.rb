require 'rails_helper'

describe 'Mercador acessa página principal de produtos' do
  it 'devendo estar autenticado' do
    visit root_path

    expect(page).not_to have_link 'Produtos'
  end

  it 'através da página inicial' do
    merchant = create(:merchant)
    product = create(:product_model)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Produtos cadastrados'
    expect(page).to have_content "Produto: #{product.name}"
    expect(page).to have_content "Marca: #{product.brand}"
    expect(page).to have_content 'Modelo: Inspiron 15'
    expect(page).to have_content "SKU: #{product.sku}"
    expect(page).to have_content "#{product.sub_category.full_description}"
  end

  it 'e não existem produtos cadastrados' do
    merchant = create(:merchant)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Não existem produtos cadastrados'
  end

  it 'e visualiza detalhes de um produto' do
    merchant = create(:merchant)
    product = create(:product_model)
    product.photos.attach(io: File.open('app/assets/images/pic_example2.jpg'), filename: 'pic_example2.jpg')

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on "#{product.name}"

    expect(current_path).to eq product_model_path(product) 
    expect(page).to have_content "Produto: #{product.name}"
    expect(page).to have_content "SKU: #{product.sku}"
    expect(page).to have_content 'Peso: 6.0kg'
    expect(page).to have_css 'img[src*="pic_example2.jpg"]'
  end

  it 'e volta para página inicial' do
    merchant = create(:merchant)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on 'E-Commerce'

    expect(current_path).to eq root_path
  end
end
