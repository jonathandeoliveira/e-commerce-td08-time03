require 'rails_helper'

describe 'mercador altera status da categoria para' do
  it 'inativa com sucesso' do
    merchant = create(:merchant)
    login_as(merchant, scope: :merchant)
    categories = create_list(:category, 3)

    visit root_path
    click_on 'Categorias'
    first(:button, 'Desativar').click

    expect(page).to have_content "Categoria #{categories[0].name} desativada com sucesso."
    expect(page).to have_content 'Situação'
    expect(page).to have_content 'Inativa'
    expect(page).to have_button 'Ativar'
  end

  it 'ativada com sucesso' do
    merchant = create(:merchant)
    login_as(merchant, scope: :merchant)
    category = create(:random_category, status: 5)

    visit root_path
    click_on 'Categorias'
    click_on 'Ativar'

    expect(page).to have_content "Categoria #{category.name} ativada com sucesso."
    expect(page).to have_content 'Situação'
    expect(page).to have_content 'Ativa'
    expect(page).to have_button 'Desativar'
  end
end
