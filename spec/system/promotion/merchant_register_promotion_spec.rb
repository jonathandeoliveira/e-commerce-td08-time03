require 'rails_helper'
include ActionView::Helpers::NumberHelper

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

    it 'com sucesso' do
      merchant = create(:merchant)
      category = create(:category)
      sub_category1 = create(:sub_category, category: category, name:'Subcategoria1')
      sub_category2 = create(:sub_category, category: category, name:'Subcategoria2')
      sub_category3 = create(:sub_category, category: category, name:'Subcategoria3')
      sub_category4= create(:sub_category, name:'Subcategoria4')
      sub_category5 = create(:sub_category, name:'Subcategoria5')
      
      login_as(merchant, scope: :merchant)
      visit root_path
      click_on 'Promoções'
      click_on 'Criar nova promoção'

      fill_in 'Nome', with: 'Semana dos Eletrônicos'
      fill_in 'Data inicial', with: Date.today
      fill_in 'Data final', with: 7.days.from_now
      fill_in 'Quantidade de cupons', with: 50
      fill_in 'Percentual de desconto', with: 5
      fill_in 'Valor máximo de desconto', with: 100
      find(:css, "#promotion_sub_category_ids_1").set(true)
      find(:css, "#promotion_sub_category_ids_3").set(true)
      find(:css, "#promotion_sub_category_ids_5").set(true)
      click_on 'Criar Promoção'

      result = Promotion.last
      expect(page).to have_content 'Promoção cadastrada com sucesso'
      expect(result.name).to eq 'Semana dos Eletrônicos'
      expect(result.used_quantity).to eq nil
      expect(result.discount_percent).to eq 5
      expect(result.sub_categories.first.name).to eq 'Subcategoria1'
    end
end
