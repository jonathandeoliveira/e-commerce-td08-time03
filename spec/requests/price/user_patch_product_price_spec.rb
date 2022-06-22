require 'rails_helper'

describe 'usuário atualiza preço de produto' do
  it 'com sucesso, alterando somente preço' do
    merchant = create(:merchant)
    product = create(:product_model)
    login_as(merchant, scope: :merchant)
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: 1.day.from_now, end_date: 30.day.from_now)
    second_price = create(:product_price, product_model: product, price: 280.0, start_date: 31.day.from_now, end_date: 60.day.from_now)
    third_price = create(:product_price, product_model: product, price: 320.0, start_date: 62.day.from_now, end_date: 92.day.from_now)

    patch("/product_models/#{product.id}/product_prices/#{first_price.id}", params: { product_price: { price: 300 } })

    expect(ProductPrice.first.price.to_f).to eq 300.0
    expect(response).to redirect_to product_model_path(product)
  end

  it 'com sucesso, alterando datas' do
    merchant = create(:merchant)
    product = create(:product_model)
    login_as(merchant, scope: :merchant)
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: 1.day.from_now, end_date: 30.day.from_now)
    second_price = create(:product_price, product_model: product, price: 280.0, start_date: 31.day.from_now, end_date: 60.day.from_now)
    third_price = create(:product_price, product_model: product, price: 320.0, start_date: 62.day.from_now, end_date: 92.day.from_now)
    start_date = Date.today + 5
    end_date = start_date + 20

    patch("/product_models/#{product.id}/product_prices/#{first_price.id}", params: { product_price: { start_date: start_date, end_date: end_date } })
    
    expect(ProductPrice.first.start_date).to eq start_date
    expect(ProductPrice.first.end_date).to eq end_date
    expect(response).to redirect_to product_model_path(product)
  end

  it 'sem sucesso, pois mercador não está autenticado' do
    product = create(:product_model)
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: 1.day.from_now, end_date: 30.day.from_now)
    second_price = create(:product_price, product_model: product, price: 280.0, start_date: 31.day.from_now, end_date: 60.day.from_now)
    third_price = create(:product_price, product_model: product, price: 320.0, start_date: 62.day.from_now, end_date: 92.day.from_now)

    patch("/product_models/#{product.id}/product_prices/#{first_price.id}", params: { product_price: { price: 300 } })

    expect(ProductPrice.first.price.to_f).not_to eq 300
    expect(response).to redirect_to new_merchant_session_path
  end

  it 'sem sucesso, pois campos são obrigatórios' do
    merchant = create(:merchant)
    product = create(:product_model)
    login_as(merchant, scope: :merchant)
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: 1.day.from_now, end_date: 30.day.from_now)
    second_price = create(:product_price, product_model: product, price: 280.0, start_date: 31.day.from_now, end_date: 60.day.from_now)
    third_price = create(:product_price, product_model: product, price: 320.0, start_date: 62.day.from_now, end_date: 92.day.from_now)

    patch("/product_models/#{product.id}/product_prices/#{first_price.id}", params: { product_price: { price: "", start_date: "", end_date: "" } })

    expect(response).to render_template(:edit)
  end

  it 'sem sucesso, pois intervalo de datas já existe' do
    merchant = create(:merchant)
    product = create(:product_model)
    login_as(merchant, scope: :merchant)
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: 1.day.from_now, end_date: 30.day.from_now)
    second_price = create(:product_price, product_model: product, price: 280.0, start_date: 31.day.from_now, end_date: 60.day.from_now)
    third_price = create(:product_price, product_model: product, price: 320.0, start_date: 62.day.from_now, end_date: 92.day.from_now)
    start_date = Date.today + 1
    end_date = start_date + 40

    patch("/product_models/#{product.id}/product_prices/#{first_price.id}", params: { product_price: { price: 310.0, start_date: start_date, end_date: end_date } })

    expect(ProductPrice.first.price).to eq 300.99
    expect(response).to render_template(:edit)
  end
end
