require 'rails_helper'

describe 'usuário cria novo preço para um produto' do
  it 'com sucesso' do
    merchant = create(:merchant)
    product = create(:product_model)
    login_as(merchant, scope: :merchant)

    post("/product_models/#{product.id}/product_prices", params: { product_price: { price: 150.00, start_date: Date.today, end_date: 5.day.from_now } })

    expect(response).to redirect_to product_model_path(product)
  end

  it 'sem sucesso, pois todos os campos são obrigatórios' do
    merchant = create(:merchant)
    product = create(:product_model)
    login_as(merchant, scope: :merchant)

    post("/product_models/#{product.id}/product_prices", params: { product_price: { price: '', start_date: '', end_date: '' } })

    expect(response).to render_template(:new)
  end
end