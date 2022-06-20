require 'rails_helper'

describe 'usuario cadastra novo produto' do
  it 'com sucesso' do 
    merchant = create(:merchant)
    subcategory = create(:sub_category)
    
    login_as(merchant, scope: :merchant)
    post product_models_path, params: { product_model: { name: 'Notebook', model:'A70' ,brand: 'Avell', description: 'Notebook gamer avell',
                                      sku: 'AVLLA7000000', length: 0.05 , weight: 1, height: 0.04, width: 0.07, sub_category_id: subcategory.id } }
    product = ProductModel.last

    expect(product.name).to eq 'Notebook'
    expect(product.sub_category.name).to eq subcategory.name
    expect(response).to redirect_to(product_model_path(product))
  end

  it 'sem sucesso, com campo em branco' do 
    merchant = create(:merchant)
    subcategory = create(:sub_category)

    login_as(merchant, scope: :merchant)
    post product_models_path, params: { product_model: { name: '', model:'A70' ,brand: 'Avell', description: 'Notebook gamer avell',
                                      sku: 'AVLLA7000000', length: 0.05 , weight: 1, height: 0.04, width: 0.07, sub_category_id: subcategory.id } }

    expect(response).to render_template(:new)
    expect(ProductModel.count).to eq 0
  end

  it 'sem sucesso por não estar autenticado' do
    subcategory = create(:sub_category)

    post product_models_path, params: { product_model: { name: 'Notebook', model:'A70' ,brand: 'Avell', description: 'Notebook gamer avell',
                                      sku: 'AVLLA7000000', length: 0.05 , weight: 1, height: 0.04, width: 0.07, sub_category_id: subcategory.id } }

     expect(response).to redirect_to(new_merchant_session_path)
  end
end