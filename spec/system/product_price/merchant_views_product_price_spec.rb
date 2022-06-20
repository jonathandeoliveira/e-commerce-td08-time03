require 'rails_helper'

describe "Mercador visualiza preço do produto" do  
  it 'a partir da tela inicial' do
    merchant = create(:merchant)
    product = create(:product_model)
    start_date = Date.today + 1
    end_date = start_date + 29
    first_price = create(:product_price, product_model: product, price: 300.99, start_date: start_date, end_date: end_date)
    second_price = create(:product_price, product_model: product, price: 280.0, start_date: 31.day.from_now, end_date: 60.day.from_now)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on product.name

    expect(page).to have_content "Preço 1: R$ 300,99"
    expect(page).to have_content "Data inicial: #{I18n.l(start_date)}"
    expect(page).to have_content "Data final: #{I18n.l(end_date)}"
    expect(page).to have_content "Preço 2: R$ 280,00"
  end

  it 'e não existem preços cadastrados' do
    merchant = create(:merchant)
    product = create(:product_model)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on product.name

    expect(page).to have_content 'Não existem preços cadastrados'
    expect(page).to have_content 'Deseja cadastrar preço?'
    expect(page).to have_link 'Cadastrar preço'
  end
end