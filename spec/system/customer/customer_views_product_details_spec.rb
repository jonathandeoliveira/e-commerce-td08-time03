require 'rails_helper'
include ActionView::Helpers::NumberHelper
describe 'usuário visualiza detalhes de produto' do
 
  it 'com sucesso' do
    product1 = create(:product_model,name:'nome1', status: :enabled)
    product2 = create(:product_model, status: :enabled)   
    price1 = create(:product_price, price: 105, product_model: product1)
    price2 = create(:product_price, price: 215, product_model: product2)
    product2.photos.attach(io: File.open('app/assets/images/pic_example2.jpg'), filename: 'pic_example2.jpg')

    visit root_path
    click_on product2.name

    expect(page).to have_content "Detalhes sobre o produto: #{product2.name}"
    expect(page).to have_content "Produto: #{product2.name}"
    expect(page).to have_content "Marca: #{product2.brand} "
    expect(page).to have_content "Modelo: #{product2.model}"
    expect(page).to have_content "Preço: RB #{number_with_precision(product2.current_price, precision: 2)}"  
    expect(page).to have_content "Categoria: #{product2.sub_category.full_description}"
    expect(page).to have_content "Descrição: #{product2.description}"
    expect(page).to have_content "Dimensões: #{product2.height}m x #{product2.width}m x #{product2.length}m"
    expect(page).to have_content "Peso: #{product2.weight}kg"
    expect(page).to have_content "SKU: #{product2.sku}"
    expect(page).to have_content "Frágil? Não"
    expect(page).to have_css 'img[src*="pic_example2.jpg"]'
  end

  it 'sem sucesso, pois produto está desativado' do
    product1 = create(:product_model, status: :disabled)
    price1 = create(:product_price, price: 105, product_model: product1)

    visit product_detail_product_model_path(product1)
    expect(page).not_to have_content "Detalhes sobre o produto: #{product1.name}"
    expect(page).to have_content "Erro! Página não encontrada :("
  end
end