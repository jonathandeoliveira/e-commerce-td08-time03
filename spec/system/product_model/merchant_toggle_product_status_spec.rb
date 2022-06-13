require 'rails_helper'

describe 'Mercador muda visibilidade de um produto' do
  it 'a partir da página inicial' do
    merchant = create(:merchant)
    produto = [create_list(:product_model, 3)]

    login_as(merchant)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Notebook-1'
    expect(page).to have_content 'Notebook-2'
    expect(page).to have_content 'Notebook-3'
    expect(page).to have_button  'Desativar'
    expect(page).not_to have_button  'Ativar'
  end
end