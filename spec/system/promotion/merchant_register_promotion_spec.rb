require 'rails_helper'

describe 'Mercador cadastra uma promoção' do
    it 'a partir da página inicial' do
      merchant = create(:merchant)

      login_as(merchant, scope: :merchant)
      visit root_path
      click_on 'Promoções'

      expect(current_path).to eq promotions_path
      expect(page).to have_content 'Todas as promoções:'
      expect(page).to have_content 'Promoção'
      expect(page).to have_content 'Código do cupom'
      expect(page).to have_content 'Situação'
      expect(page).to have_link 'Criar nova promoção'
    end

    xit 'com sucesso' do
      merchant = create(:merchant)
      sub_category1 = create(:subcategory)
      sub_category2 = create(:subcategory)
      sub_category3 = create(:subcategory)
      sub_category4= create(:subcategory)
      sub_category5 = create(:subcategory)
      

      login_as(merchant, scope: :merchant)
      visit root_path
      click_on 'Promoções'
      click_on 'Criar nova promoção'

      fill_in 'Nome', with: 'Semana dos Eletrônicos'
      fill_in 'Data inicial', with: Date.today
      fill_in 'Data final', with: 7.days.from_now
      fill_in 'Quantidade de cupons', with: 50
      fill_in 'Percentagem de desconto', with: 5
      fill_in 'Desconto máximo(em reais)', with: 100
      find(:css, "#sub_categoryID[value=1").set(true)
      find(:css, "#sub_categoryID[value=2").set(true)
      find(:css, "#sub_categoryID[value=5").set(true)

      expect(page).to have_content ''
    end
end
