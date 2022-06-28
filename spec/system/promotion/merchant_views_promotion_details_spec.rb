require 'rails_helper'

describe 'mercador vê detalhes de uma promoção' do
  it 'com sucesso' do
    merchant = create(:merchant)
    sub_category1 = create(:sub_category, name:'Subcategoria1')
    sub_category2 = create(:sub_category,name:'Subcategoria2')
    promotion = create(:promotion)
    promotion_category1 = create(:promotion_category, promotion: promotion, sub_category: sub_category1)
    promotion_category1 = create(:promotion_category, promotion: promotion, sub_category: sub_category2)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Promoções'
    click_on "#{promotion.name}"

    expect(page).to have_content "Detalhes da promoção: #{promotion.name}"
    expect(page).to have_content "Código do cupom: #{promotion.code}"
    expect(page).to have_content "Situação: Ativa"
    expect(page).to have_content "Data inicial: #{promotion.start_date}"
    expect(page).to have_content "Data final: #{promotion.end_date}"
    expect(page).to have_content "Quantidade de cupons criados: #{promotion.max_quantity}"
    expect(page).to have_content "Quantidade de cupons usada: #{promotion.used_quantity}"
    expect(page).to have_content "Percentual de desconto: #{promotion.discount_percent}%"
    expect(page).to have_content "Valor máximo de desconto: R$ 0,40"
    expect(page).to have_content "Categorias em promoção: "
    expect(page).to have_content "Subcategoria1"
    expect(page).to have_content "Subcategoria2"
  end

  it 'se autenticado' do
    merchant = create(:merchant)
    sub_category1 = create(:sub_category, name:'Subcategoria1')
    sub_category2 = create(:sub_category,name:'Subcategoria2')
    promotion = create(:promotion)
    promotion_category1 = create(:promotion_category, promotion: promotion, sub_category: sub_category1)
    promotion_category1 = create(:promotion_category, promotion: promotion, sub_category: sub_category2)

    visit promotion_path(promotion)
    expect(current_path).not_to eq promotion_path(promotion)
    expect(current_path).to eq new_merchant_session_path
  end
end
