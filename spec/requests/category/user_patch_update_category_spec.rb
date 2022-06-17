require 'rails_helper'

describe 'usuario atualiza categoria' do
  it 'com sucesso' do
    merchant = create(:merchant)
    category = create(:random_category)

    login_as(merchant, scope: :merchant)
    patch("/categories/#{category.id}", params: { category: { name: 'Eletrônicos' } })

    expect(Category.first.name).to eq 'Eletrônicos'
    expect(response).to redirect_to(categories_path)
  end

  it 'sem sucesso' do
    merchant = create(:merchant)
    category = create(:random_category)

    login_as(merchant, scope: :merchant)
    patch("/categories/#{category.id}", params: { category: { name: '' } })

    expect(response).to render_template(:edit)
  end
end

describe 'usuario muda status de categoria' do
  it 'para inativa, sem sucesso, pois necessita autenticação' do
    category = create(:random_category)

    patch("/categories/#{category.id}/disable")

    expect(response).to redirect_to new_merchant_session_path
  end

  it 'para ativa, sem sucesso, pois necessita autenticação' do
    category = create(:random_category, status: 5)

    patch("/categories/#{category.id}/enable")

    expect(response).to redirect_to new_merchant_session_path
  end

  it 'para inativa, com sucesso' do
    merchant = create(:merchant)
    category = create(:random_category)

    login_as(merchant, scope: :merchant)
    patch("/categories/#{category.id}/disable")

    expect(response).to redirect_to categories_path
  end

  it 'para ativa, com sucesso' do
    merchant = create(:merchant)
    category = create(:random_category, status: 5)

    login_as(merchant, scope: :merchant)
    patch("/categories/#{category.id}/enable")

    expect(response).to redirect_to categories_path
  end
end
