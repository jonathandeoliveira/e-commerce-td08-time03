require 'rails_helper'

describe 'Mercador muda visibilidade de um produto' do
  it 'a partir da página inicial' do
    merchant = create(:merchant)
    create(:product_model)

    login_as(merchant)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Notebook'
    expect(page).to have_button  'Desativar'
    expect(page).not_to have_button  'Ativar'
  end

  it 'e desabilita-o' do
    merchant = create(:merchant)
    product = create(:product_model)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on 'Desativar'

    expect(page).to have_button 'Ativar'
    expect(page).not_to have_button  'Desativar'
    expect(page).to have_content 'Produto desativado com sucesso'
    expect(page).to have_content 'Situação: Fora de estoque'
    product = product.reload
    result = product.status
    expect(result).to eq 'disabled'
  end

  it 'e ativa-o' do
    merchant = create(:merchant)
    product = create(:product_model, status:0)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Produtos'
    click_on 'Ativar'

    expect(page).not_to have_button  'Ativar'
    expect(page).to have_button 'Desativar'
    expect(page).to have_content 'Produto ativado com sucesso'
    expect(page).to have_content 'Situação: Em estoque'
    product = product.reload
    result = product.status
    expect(result).to eq 'enabled'
  end
end