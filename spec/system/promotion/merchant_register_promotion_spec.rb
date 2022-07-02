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
      allow(SecureRandom).to receive(:alphanumeric).and_return('8DIGITOS')
      click_on 'Criar Promoção'
      
      result = Promotion.last
      expect(page).to have_content 'Promoção cadastrada com sucesso'
      expect(page).to have_content "Detalhes da promoção: Semana dos Eletrônicos"
      expect(page).to have_content 'Situação: Ativa'
      expect(page).to have_content "Data inicial: #{result.start_date}"
      expect(page).to have_content "Data final: #{result.end_date}"
      expect(page).to have_content "Quantidade de cupons criados: 50"
      expect(page).to have_content "Quantidade de cupons usada: 0"
      expect(page).to have_content "Percentual de desconto: 5%"
      expect(page).to have_content "Valor máximo de desconto: R$ 100,00"
      expect(page).to have_content "Categorias em promoção:"
      expect(page).to have_content "Subcategoria1"
      expect(page).to have_content "Subcategoria3"
      expect(page).to have_content "Subcategoria5"
      expect(result.name).to eq 'Semana dos Eletrônicos'
      expect(result.used_quantity).to eq 0
      expect(result.discount_percent).to eq 5
      expect(result.sub_categories.first.name).to eq 'Subcategoria1'
      expect(result.code).to eq '8DIGITOS'
      expect(result.status).to eq 'active'
    end

    it 'se estiver autenticado' do
      visit new_promotion_path      

      expect(current_path).not_to eq new_promotion_path
      expect(current_path).to eq new_merchant_session_path
    end

    it 'com campos em branco' do
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

      fill_in 'Nome', with: ''
      fill_in 'Data inicial', with: ''
      fill_in 'Data final', with: ''
      fill_in 'Quantidade de cupons', with: ''
      fill_in 'Percentual de desconto', with: ''
      fill_in 'Valor máximo de desconto', with: ''
      click_on 'Criar Promoção'
      
      result = Promotion.all.count
      expect(result).to eq 0
      expect(page).to have_content 'Erro! Não foi possível cadastrar nova promoção :('
      expect(page).to have_content 'Nome não pode ficar em branco'
      expect(page).to have_content 'Data inicial não pode ficar em branco'
      expect(page).to have_content 'Data final não pode ficar em branco'
      expect(page).to have_content 'Quantidade de cupons criados não pode ficar em branco e Quantidade de cupons criados não é um número'
      expect(page).to have_content 'Percentual de desconto não pode ficar em branco e Percentual de desconto não é um número'
      expect(page).to have_content 'Valor máximo de desconto não pode ficar em branco e Valor máximo de desconto não é um número'
      expect(page).to have_content 'Subcategoria não pode ficar em branco'
    end

    it 'com campos inválidos' do
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

      fill_in 'Nome', with: 'Super Promoção'
      fill_in 'Data inicial', with: 7.days.ago
      fill_in 'Data final', with: 7.days.ago
      fill_in 'Quantidade de cupons', with: -1
      fill_in 'Percentual de desconto', with: -1
      fill_in 'Valor máximo de desconto', with: -1
      click_on 'Criar Promoção'
      
      result = Promotion.all.count
      expect(result).to eq 0
      expect(page).to have_content 'Erro! Não foi possível cadastrar nova promoção :('
      expect(page).to have_content 'Data inicial não pode ser no passado.'
      expect(page).to have_content 'Data final não pode ser no passado.'
      expect(page).to have_content 'Data inicial e data final não podem ser iguais.'
      expect(page).to have_content 'Quantidade de cupons criados deve ser maior que 0'
      expect(page).to have_content 'Percentual de desconto deve ser maior que 0'
      expect(page).to have_content 'Valor máximo de desconto deve ser maior que 0'
    end
end
