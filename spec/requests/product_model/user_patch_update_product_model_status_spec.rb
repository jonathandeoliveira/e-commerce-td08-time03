require 'rails_helper'

describe 'requisição para mudar status de um produto' do
  it 'para inativa, sem sucesso, pois necessita autenticação' do
    product = create(:product_model)

    patch disable_product_model_path(product)

    expect(response).to redirect_to new_merchant_session_path
    product.reload
    expect(product.status).to eq 'disabled'
  end

  it 'para ativa, sem sucesso, pois necessita autenticação' do
    product = create(:product_model, status: :disabled)

    patch enable_product_model_path(product)

    expect(response).to redirect_to new_merchant_session_path
    product.reload
    expect(product.status).to eq 'disabled'
  end

  it 'para inativa, com sucesso' do
    merchant = create(:merchant)
    product = create(:product_model, status: :enabled)

    login_as(merchant, scope: :merchant)
    patch disable_product_model_path(product)

    expect(response).to redirect_to product_models_path
    product.reload
    expect(product.status).to eq 'disabled'
  end

  it 'para ativa, com sucesso' do
    merchant = create(:merchant)
    product = create(:product_model)
    price = create(:product_price, product_model: product)
    
    login_as(merchant, scope: :merchant)
    patch enable_product_model_path(product)

    expect(response).to redirect_to product_models_path
    product.reload
    expect(product.status).to eq 'enabled'
  end
end