require 'rails_helper'

describe 'mercador visualiza categorias cadastradas' do
  it 'somente se estiver autenticado' do
    visit categories_path

    expect(current_path).to eq new_merchant_session_path
  end

  it 'e não existem categorias cadastradas' do
    merchant = create(:merchant)
    login_as(merchant, scope: :merchant)

    visit root_path
    click_on 'Categorias'

    expect(page).to have_content 'Não existem categorias cadastradas'
  end

  it 'a partir da tela inicial' do
    merchant = create(:merchant)
    first_category = create(:random_category)
    second_category = create(:random_category)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Categorias'

    expect(page).to have_content 'Categorias'
    expect(page).to have_content "Nome: #{first_category.name}"
    expect(page).to have_content 'Status: Ativa'
    expect(page).to have_content "Nome: #{second_category.name}"
    expect(page).to have_content 'Status: Ativa'
  end
end
