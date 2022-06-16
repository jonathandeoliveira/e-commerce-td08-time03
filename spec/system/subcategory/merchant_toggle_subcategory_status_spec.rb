require 'rails_helper'

describe 'Mercador muda situação de uma subcategoria' do
  it 'a partir da página inicial' do
    merchant = create(:merchant)
    category = create(:random_category)
    create(:sub_category)

    login_as(merchant)
    visit root_path
    click_on 'Categorias'
    click_on "#{category.name}"

    within('section#subcategories') do
      expect(page).to have_content "#{SubCategory.model_name.human}:"
      expect(page).to have_button 'Desativar'
      expect(page).not_to have_button 'Ativar'
    end
  end

  it 'para inativa com sucesso' do
    merchant = create(:merchant)
    category = create(:random_category)
    subcategory = create(:sub_category)

    login_as(merchant)
    visit root_path
    click_on 'Categorias'
    click_on "#{category.name}"
    within('section#subcategories') do
      click_on 'Desativar'
    end

    subcategory = subcategory.reload
    result = subcategory.status
    expect(result).to eq 'disabled'
    expect(page).to have_content "Subcategoria: #{subcategory.name} desativada com sucesso."
    within('section#subcategories') do
      expect(page).to have_button 'Ativar'
      expect(page).not_to have_button 'Desativar'
    end
  end

  it 'para inativa com sucesso' do
    merchant = create(:merchant)
    category = create(:random_category)
    subcategory = create(:sub_category, status: :disabled)

    login_as(merchant)
    visit root_path
    click_on 'Categorias'
    click_on "#{category.name}"
    within('section#subcategories') do
      click_on 'Ativar'
    end

    subcategory = subcategory.reload
    result = subcategory.status
    expect(result).to eq 'enabled'
    expect(page).to have_content "Subcategoria: #{subcategory.name} ativada com sucesso."
    within('section#subcategories') do
      expect(page).to have_button 'Desativar'
      expect(page).not_to have_button 'Ativar'
    end
  end
end
