require 'rails_helper'

describe 'Usuário pesquisa produtos' do
  it 'por categoria, com sucesso' do 
    first_subcategory = create(:sub_category)
    second_subcategory = create(:sub_category)
    visible_product = create(:product_model,status: :enabled, sub_category: first_subcategory)
    visible_product2 = create(:product_model,status: :enabled, sub_category: first_subcategory)  
    first_price = create(:product_price, product_model: visible_product)
    second_price = create(:product_price, product_model: visible_product2)

    get search_category_sub_categories_path(first_subcategory, params: {query: first_subcategory})
    expect(response).to have_http_status 200
    expect(response).to render_template('sub_categories/search')
  end

  it 'por nome, com sucesso' do
    first_subcategory = create(:sub_category)
    second_subcategory = create(:sub_category)
    visible_product = create(:product_model, name:'Bicicleta',status: :enabled, sub_category: first_subcategory)
    visible_product2 = create(:product_model,status: :enabled, sub_category: first_subcategory)  
    first_price = create(:product_price, product_model: visible_product)
    second_price = create(:product_price, product_model: visible_product2)

    get search_product_models_path(params: {query: "Bi"})
    expect(response).to have_http_status 200
    expect(response).to render_template('product_models/search')
  end

end