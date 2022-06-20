require 'rails_helper'

describe 'usuário registra nova categoria' do
  it 'com sucesso' do
    merchant = create(:merchant)
    category = create(:random_category)

    login_as(merchant, scope: :merchant)
    post(category_sub_categories_path(category, params: { sub_category: { name: 'Notebook' } }))

    expect(SubCategory.first.name).to eq 'Notebook'
    expect(SubCategory.first.category_id).to eq 1
    expect(response).to redirect_to(category_path(category))
  end

  it 'sem sucesso, com o nome em branco' do
    merchant = create(:merchant)
    create(:random_category)

    login_as(merchant, scope: :merchant)
    post('/categories/1/sub_categories', params: { sub_category: { name: '' } })

    expect(response).to render_template(:new)
    expect(SubCategory.count).to eq 0
  end

  it 'sem estar logado' do
    category = create(:random_category)

    post category_sub_categories_path(category, params: { sub_category: { name: 'Notebook' } })

    expect(response).to redirect_to(new_merchant_session_path)
  end
end
