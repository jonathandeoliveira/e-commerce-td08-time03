require 'rails_helper'
include ActionView::Helpers::NumberHelper

describe 'Usuário vê produtos do ecommerce' do

  it 'na página principal' do
    product1 = create(:product_model, status: :enabled)
    product2 = create(:product_model, status: :enabled)
    price1 = create(:product_price, product_model: product1)
    price2 = create(:product_price, price: 215, product_model: product2)

    visit root_path

    expect(page).to have_content 'Nossos produtos:'
    expect(page).to have_content product1.name
    expect(page).to have_content product2.name
    expect(page).to have_content number_to_currency(price1.price)
    expect(page).to have_content number_to_currency(price2.price)
  end

  it 'e não vê produtos cadastrados' do
    visit root_path

    expect(page).to have_content "Nenhum produto encontrado com os parâmetros da busca #{'¯\_(ツ)_/¯'}"
  end

  it 'e não vê produtos desabilitados' do
    product1 = create(:product_model, status: :disabled)
    product2 = create(:product_model, status: :enabled)
    price1 = create(:product_price, product_model: product1)
    price2 = create(:product_price, price: 215, product_model: product2)

    visit root_path

    expect(page).not_to have_content product1.name
    expect(page).not_to have_content number_to_currency(price1.price)
    expect(page).to have_content product2.name
    expect(page).to have_content number_to_currency(price2.price)
  end

  it 'e vê o preço na data correta' do
    product1 = create(:product_model, status: :enabled)
    product2 = create(:product_model, status: :enabled)
    price1 = create(:product_price, product_model: product1)
    price2 = create(:product_price, price: 215, product_model: product2)
    price3 = create(:product_price, price: 300, product_model: product1, start_date: 4.months.from_now, end_date: 5.months.from_now)
    price4 = create(:product_price, price: 400, product_model: product2, start_date: 4.months.from_now, end_date: 5.months.from_now)

    visit root_path

    expect(page).to have_content 'Nossos produtos:'
    expect(page).to have_content product1.name
    expect(page).to have_content product2.name
    expect(page).to have_content number_to_currency(price1.price)
    expect(page).to have_content number_to_currency(price2.price)
    expect(page).not_to have_content number_to_currency(price3.price)
    expect(page).not_to have_content number_to_currency(price4.price)
  end

  context 'E navega entre categorias' do
      it 'e vê selectbox de categorias' do
        visit root_path

        expect(page).to have_field 'Categorias'
      end

      it 'e pesquisa produtos de uma categoria' do
        first_subcategory = create(:sub_category)
        second_subcategory = create(:sub_category)
        visible_product = create(:product_model, sub_category: first_subcategory)
        visible_product2 = create(:product_model, sub_category: first_subcategory)
        not_visible_product = create(:product_model, sub_category: second_subcategory)
        first_price = create(:product_price, product_model: visible_product)
        second_price = create(:product_price, product_model: visible_product2)
        third_price = create(:product_price, product_model: not_visible_product, price: 599)
        
        visit root_path
        select "#{first_subcategory.full_description}", from: 'Categorias'
        click_on 'Buscar'

        expect(page).to have_content "Produtos da categoria: #{first_subcategory.full_description}"
        expect(page).to have_content "#{visible_product.name}"
        expect(page).to have_content "#{number_to_currency(visible_product.product_prices.first.price)}"
        expect(page).to have_content "#{visible_product2.name}"
        expect(page).to have_content "#{number_to_currency(visible_product2.product_prices.first.price)}"
        expect(page).not_to have_content "#{not_visible_product.name}"
        expect(page).not_to have_content "#{number_to_currency(not_visible_product.product_prices.first.price)}"
      end

      it 'e pesquisa produtos de uma categoria, mas não existem produtos cadastrados' do
        first_subcategory = create(:sub_category)
        second_subcategory = create(:sub_category)
        visible_product = create(:product_model, sub_category: first_subcategory)
        first_price = create(:product_price, product_model: visible_product)

        visit root_path
        select "#{second_subcategory.full_description}", from: 'Categorias'
        click_on 'Buscar'
        expect(page).to have_content "Produtos da categoria: #{second_subcategory.full_description}"
        expect(page).to have_content "Nenhum produto encontrado com os parâmetros da busca #{'¯\_(ツ)_/¯'}"
      end
  end

  context 'E faz uma busca de produto' do
    it 'com sucesso' do
      first_subcategory = create(:sub_category)
      second_subcategory = create(:sub_category)
      visible_product = create(:product_model, sub_category: first_subcategory, status: :enabled)
      visible_product2 = create(:product_model, sub_category: first_subcategory, status: :enabled)
      not_visible_product = create(:product_model, sub_category: second_subcategory, status: :disabled)
      first_price = create(:product_price, product_model: visible_product)
      second_price = create(:product_price, product_model: visible_product2)
      third_price = create(:product_price, product_model: not_visible_product, price: 599)
      

      visit root_path      
      fill_in 'Buscar produto', with: "#{visible_product2.name}"
      within('section#query_product') do
        click_on 'Buscar'
      end      

      expect(page).to have_content "Resultado da busca por: #{visible_product2.name}"
      expect(page).to have_content "#{visible_product2.name}"
      expect(page).to have_content "#{number_to_currency(visible_product2.product_prices.first.price)}"
    end

    it 'e busca múltiplos itens' do
      first_subcategory = create(:sub_category)
      second_subcategory = create(:sub_category)
      visible_product = create(:product_model,name:'Laptop da Xuxa' , sub_category: first_subcategory, status: :enabled)
      visible_product2 = create(:product_model, name:'Lego' , sub_category: first_subcategory, status: :enabled)
      not_searched_product = create(:product_model, name:'Massinha', sub_category: second_subcategory, status: :enabled)
      first_price = create(:product_price, product_model: visible_product)
      second_price = create(:product_price, product_model: visible_product2)
      third_price = create(:product_price, product_model: not_searched_product, price: 599)

      visit root_path      
      fill_in 'Buscar produto', with: "O"
      within('section#query_product') do
        click_on 'Buscar'
      end      

      expect(page).to have_content "Resultado da busca por: O"
      expect(page).to have_content "Lego"
      expect(page).to have_content "#{number_to_currency(visible_product2.product_prices.first.price)}"
      expect(page).to have_content "Laptop da Xuxa"
      expect(page).to have_content "#{number_to_currency(visible_product.product_prices.first.price)}"
      expect(page).not_to have_content "Massinha"
      expect(page).not_to have_content "#{number_to_currency(not_searched_product.product_prices.first.price)}"
    end

    it 'e não encontra resultados na busca' do
      first_subcategory = create(:sub_category)
      second_subcategory = create(:sub_category)
      visible_product = create(:product_model,name:'Laptop da Xuxa' , sub_category: first_subcategory, status: :enabled)
      visible_product2 = create(:product_model, name:'Lego' , sub_category: first_subcategory, status: :enabled)
      not_searched_product = create(:product_model, name:'Massinha', sub_category: second_subcategory, status: :enabled)
      first_price = create(:product_price, product_model: visible_product)
      second_price = create(:product_price, product_model: visible_product2)
      third_price = create(:product_price, product_model: not_searched_product, price: 599)

      visit root_path      
      fill_in 'Buscar produto', with: "O"
      within('section#query_product') do
        click_on 'Buscar'
      end      

      expect(page).to have_content "Resultado da busca por: O"

    end
    
  end

end