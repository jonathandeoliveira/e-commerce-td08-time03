require 'rails_helper'

describe 'mercador registra nova subcategoria' do
  it 'a partir da pagina inicial' do
    merchant = create(:merchant)
    category = create(:random_category)

    login_as(merchant)
    visit root_path
    click_on 'Categorias'
    click_on "#{category.name}"

    expect(current_path).to eq category_path(category)
    expect(page).to have_button('Nova subcategoria')
  end

  it 'com sucesso' do
    merchant = create(:merchant)
    category = create(:category)

    login_as(merchant)
    visit root_path
    click_on 'Categorias'
    click_on "#{category.name}"
    click_on 'Nova subcategoria'
    fill_in 'Nome', with: 'Notebooks'
    click_on 'Criar Subcategoria'

    expect(page).to have_content 'Subcategoria criada com sucesso.'
    expect(SubCategory.last.name).to eq 'Notebooks'
  end
end
