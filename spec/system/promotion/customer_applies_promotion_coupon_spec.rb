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
    customer = create(:customer, balance: 100000)
    product = create(:product_model, name: 'Notebook', status: 'enabled')
    second_product = create(:product_model, name: 'TV', status: 'enabled')
    first_price = create(:product_price, product_model: product, price: 300, start_date: Date.today, end_date: 100.day.from_now)
    second_price = create(:product_price, product_model: second_product, price: 500, start_date: Date.today, end_date: 100.day.from_now)
    first_item = create(:product_item, customer: customer, product_model: product, quantity: 2)
    second_item = create(:product_item, customer: customer, product_model: second_product, quantity: 2)
    promotion = create(:promotion, sub_categories:[product.sub_category, second_product.sub_category], max_discount_money: 500)
    discount_1 = product.current_price.round(2) * ((promotion.discount_percent.to_f/100)) * first_item.quantity
    discount_2 = second_product.current_price.round(2) * ((promotion.discount_percent.to_f/100)) * second_item.quantity
    total_discount = discount_1 + discount_2
    sub_total = product.current_price.round(2) * first_item.quantity + second_product.current_price.round(2) * second_item.quantity
    total = sub_total - total_discount    

    allow(SecureRandom).to receive(:alphanumeric).and_return('QUINZCARACTERES')
    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'
    click_on 'Finalizar pedido'
    fill_in 'coupon', with: "#{promotion.code}"
    click_on 'Aplicar cupom'
    click_on 'Confirmar'    
    
    expect(page).to have_content 'QUINZCARACTERES'
    expect(page).to have_content "RB 50,67"         
  end

  it 'e limita o desconto caso passe do desconto máximo' do
    customer = create(:customer, balance: 100000)
    product = create(:product_model, name: 'Notebook', status: 'enabled')
    second_product = create(:product_model, name: 'TV', status: 'enabled')
    first_price = create(:product_price, product_model: product, price: 300, start_date: Date.today, end_date: 100.day.from_now)
    second_price = create(:product_price, product_model: second_product, price: 500, start_date: Date.today, end_date: 100.day.from_now)
    first_item = create(:product_item, customer: customer, product_model: product, quantity: 2)
    second_item = create(:product_item, customer: customer, product_model: second_product, quantity: 2)
    promotion = create(:promotion, sub_categories:[product.sub_category, second_product.sub_category], max_discount_money: 5, discount_percent: 20)
    discount_1 = product.current_price.round(2) * ((promotion.discount_percent.to_f/100)) * first_item.quantity
    discount_2 = second_product.current_price.round(2) * ((promotion.discount_percent.to_f/100)) * second_item.quantity
    total_discount = discount_1 + discount_2
    sub_total = product.current_price.round(2) * first_item.quantity + second_product.current_price.round(2) * second_item.quantity
    total = sub_total - promotion.max_discount_money   

    allow(SecureRandom).to receive(:alphanumeric).and_return('QUINZCARACTERES')
    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'
    click_on 'Finalizar pedido'
    fill_in 'coupon', with: "#{promotion.code}"
    click_on 'Aplicar cupom'
    click_on 'Confirmar' 
    
    
    expect(page).to have_content 'QUINZCARACTERES'
    expect(page).to have_content "RB 48,34"  

  end

  it 'e aplica um cupom que não está expirado' do
    customer = create(:customer, balance: 100000)
    product = create(:product_model, name: 'Notebook', status: 'enabled')
    second_product = create(:product_model, name: 'TV', status: 'enabled')
    first_price = create(:product_price, product_model: product, price: 300, start_date: Date.today, end_date: 100.day.from_now)
    second_price = create(:product_price, product_model: second_product, price: 500, start_date: Date.today, end_date: 100.day.from_now)
    first_item = create(:product_item, customer: customer, product_model: product, quantity: 2)
    second_item = create(:product_item, customer: customer, product_model: second_product, quantity: 2) 
    promotion = create(:promotion, sub_categories:[product.sub_category, second_product.sub_category], max_discount_money: 500, status: :inactive)

    allow(SecureRandom).to receive(:alphanumeric).and_return('QUINZCARACTERES')
    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'
    click_on 'Finalizar pedido'
    fill_in 'coupon', with: "#{promotion.code}"
    click_on 'Aplicar cupom'        
    
    expect(page).to have_content 'Cupom expirado'           

  end
  
  it 'e aplica um cupom que não existe' do
    customer = create(:customer, balance: 100000)
    product = create(:product_model, name: 'Notebook', status: 'enabled')
    second_product = create(:product_model, name: 'TV', status: 'enabled')
    first_price = create(:product_price, product_model: product, price: 300, start_date: Date.today, end_date: 100.day.from_now)
    second_price = create(:product_price, product_model: second_product, price: 500, start_date: Date.today, end_date: 100.day.from_now)
    first_item = create(:product_item, customer: customer, product_model: product, quantity: 2)
    second_item = create(:product_item, customer: customer, product_model: second_product, quantity: 2)     

    allow(SecureRandom).to receive(:alphanumeric).and_return('QUINZCARACTERES')
    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'
    click_on 'Finalizar pedido'
    fill_in 'coupon', with: "CUPOMINEXISTENTE"
    click_on 'Aplicar cupom'        
    
    expect(page).to have_content 'Cupom não existe'     
  end

  it 'aplica cupom e aumenta quantidade de cupons usados' do
    customer = create(:customer, balance: 100000)
    product = create(:product_model, name: 'Notebook', status: 'enabled')
    second_product = create(:product_model, name: 'TV', status: 'enabled')
    first_price = create(:product_price, product_model: product, price: 300, start_date: Date.today, end_date: 100.day.from_now)
    second_price = create(:product_price, product_model: second_product, price: 500, start_date: Date.today, end_date: 100.day.from_now)
    first_item = create(:product_item, customer: customer, product_model: product, quantity: 2)
    second_item = create(:product_item, customer: customer, product_model: second_product, quantity: 2)
    promotion = create(:promotion, sub_categories:[product.sub_category, second_product.sub_category], max_discount_money: 500)
   

    allow(SecureRandom).to receive(:alphanumeric).and_return('QUINZCARACTERES')
    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'
    click_on 'Finalizar pedido'
    fill_in 'coupon', with: "#{promotion.code}"
    click_on 'Aplicar cupom'
    click_on 'Confirmar'

    expect(Promotion.first.used_quantity).to eq 1

  end

  it 'e não aplica cupom porque qtd de cupons se excedeu' do
    customer = create(:customer, balance: 100000)
    product = create(:product_model, name: 'Notebook', status: 'enabled')
    second_product = create(:product_model, name: 'TV', status: 'enabled')
    first_price = create(:product_price, product_model: product, price: 300, start_date: Date.today, end_date: 100.day.from_now)
    second_price = create(:product_price, product_model: second_product, price: 500, start_date: Date.today, end_date: 100.day.from_now)
    first_item = create(:product_item, customer: customer, product_model: product, quantity: 2)
    second_item = create(:product_item, customer: customer, product_model: second_product, quantity: 2)
    promotion = create(:promotion, sub_categories:[product.sub_category, second_product.sub_category], used_quantity: 10, max_quantity: 10)
   

    allow(SecureRandom).to receive(:alphanumeric).and_return('QUINZCARACTERES')
    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meu carrinho'
    click_on 'Finalizar pedido'
    fill_in 'coupon', with: "#{promotion.code}"
    click_on 'Aplicar cupom'    

    expect(page).to have_content 'Cupom expirado'

  end
end