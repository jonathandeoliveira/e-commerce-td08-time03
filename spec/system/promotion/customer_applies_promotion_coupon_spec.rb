require 'rails_helper'

describe 'cliente aplica cupom de desconto à compra' do
  it 'a partir da tela inicial' do
    customer = create(:customer)
    product = create(:product_model, name: 'Notebook', status: 'enabled')
    second_product = create(:product_model, name: 'TV', status: 'enabled')
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: Date.today, end_date: 100.day.from_now)
    second_price = create(:product_price, product_model: second_product, price: 500.99, start_date: Date.today, end_date: 100.day.from_now)
    first_item = create(:product_item, customer: customer, product_model: product)
    second_item = create(:product_item, customer: customer, product_model: second_product)
    allow(SecureRandom).to receive(:alphanumeric).and_return('QUINZCARACTERES')

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'
    click_on 'Finalizar pedido'

    expect(page).to have_field 'coupon'
  end

  it 'e aplica um cupom válido' do
    customer = create(:customer)
    product = create(:product_model, name: 'Notebook', status: 'enabled')
    second_product = create(:product_model, name: 'TV', status: 'enabled')
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: Date.today, end_date: 100.day.from_now)
    second_price = create(:product_price, product_model: second_product, price: 500.99, start_date: Date.today, end_date: 100.day.from_now)
    first_item = create(:product_item, customer: customer, product_model: product)
    second_item = create(:product_item, customer: customer, product_model: second_product)
    promotion = create(:promotion, sub_categories:[product.sub_category, second_product.sub_category])
    allow(SecureRandom).to receive(:alphanumeric).and_return('QUINZCARACTERES')

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'
    click_on 'Finalizar pedido'
    fill_in 'coupon', with: "#{promotion.code}"
    click_on 'Aplicar cupom'

    expect(page).to have_content 'Cupom aplicado com sucesso'
  end

  it 'e o cupom dá o desconto' do
    customer = create(:customer)
    product = create(:product_model, name: 'Notebook', status: 'enabled')
    second_product = create(:product_model, name: 'TV', status: 'enabled')
    first_price = create(:product_price, product_model: product, price: 300, start_date: Date.today, end_date: 100.day.from_now)
    second_price = create(:product_price, product_model: second_product, price: 500, start_date: Date.today, end_date: 100.day.from_now)
    first_item = create(:product_item, customer: customer, product_model: product, quantity: 3)
    second_item = create(:product_item, customer: customer, product_model: second_product, quantity: 5)
    promotion = create(:promotion, sub_categories:[product.sub_category, second_product.sub_category], max_discount_money: 500)
    allow(SecureRandom).to receive(:alphanumeric).and_return('QUINZCARACTERES')
    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'
    click_on 'Finalizar pedido'
    fill_in 'coupon', with: "#{promotion.code}"
    click_on 'Aplicar cupom'
    
    
    expect(page).to have_content 'Cupom aplicado com sucesso'
    expect(page).to have_content '855'
    expect(page).to have_content '2375' 
  end

end