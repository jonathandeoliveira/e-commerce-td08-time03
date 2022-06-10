require 'rails_helper'

describe 'mercador visualiza categorias cadastradas' do
    it 'se autenticado' do
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
      login_as(merchant, scope: :merchant)
      first_category = Category.create!(name: 'Eletrônicos')
      second_category = Category.create!(name: 'Cozinha')

      visit root_path
      click_on 'Categorias'

      expect(page).to have_content 'Categorias'
      expect(page).to have_content 'Nome: Eletrônicos'
      expect(page).to have_content 'Status: Ativa'
      expect(page).to have_content 'Nome: Cozinha'
      expect(page).to have_content 'Status: Ativa'
  end

end