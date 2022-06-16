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
    expect(page).to have_link('Nova subcategoria')
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

  it 'e não preenche o campo' do
    merchant = create(:merchant)
    category = create(:category)

    login_as(merchant)
    visit root_path
    click_on 'Categorias'
    click_on "#{category.name}"
    click_on 'Nova subcategoria'
    fill_in 'Nome', with: ''
    click_on 'Criar Subcategoria'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Falha ao criar subcategoria.'
  end

  it 'e não preenche o campo' do
    merchant = create(:merchant)
    category = create(:category)
    subcategory = create(:sub_category)

    login_as(merchant)
    visit root_path
    click_on 'Categorias'
    click_on "#{category.name}"
    click_on 'Nova subcategoria'
    fill_in 'Nome', with: "#{subcategory.name}"
    click_on 'Criar Subcategoria'

    expect(page).to have_content 'Falha ao criar subcategoria.'
    expect(page).to have_content 'Nome já está em uso'
  end
end
