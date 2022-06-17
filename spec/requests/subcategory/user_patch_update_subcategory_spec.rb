require 'rails_helper'

describe 'usuario muda status de subcategoria' do
  it 'para inativa, sem sucesso, pois necessita autenticação' do
    create(:random_category)
    subcategory = create(:sub_category)

    patch('/categories/1/sub_categories/1/disable')

    expect(response).to redirect_to new_merchant_session_path
    subcategory.reload
    expect(subcategory.status).to eq 'enabled'
  end

  it 'para inativa, com sucesso' do
    merchant = create(:merchant)
    category = create(:random_category)
    subcategory = create(:sub_category)

    login_as(merchant, scope: :merchant)
    patch('/categories/1/sub_categories/1/disable')

    subcategory.reload
    result = subcategory.status
    expect(response).to redirect_to category_path(category)
    expect(result).to eq 'disabled'
  end

  it 'para ativa, com sucesso' do
    merchant = create(:merchant)
    category = create(:random_category)
    subcategory = create(:sub_category, status: :disabled)

    login_as(merchant, scope: :merchant)
    patch('/categories/1/sub_categories/1/enable')

    subcategory.reload
    result = subcategory.status
    expect(response).to redirect_to category_path(category)
    expect(result).to eq 'enabled'
  end

  it 'para ativa, sem sucesso pois necessita autenticação' do
    create(:random_category)
    create(:sub_category)

    patch('/categories/1/sub_categories/1/enable')

    expect(response).to redirect_to new_merchant_session_path
  end
end
