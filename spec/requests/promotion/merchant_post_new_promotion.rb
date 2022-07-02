require 'rails_helper'

describe 'usuário cadastra nova promocaão' do
  it 'com sucesso' do
    merchant = create(:merchant)
    subcategory1 = create(:sub_category)
    subcategory2 = create(:sub_category)

    login_as(merchant, scope: :merchant)
    post promotions_path, params: { promotion: {name: 'Promoção', start_date: Date.today, end_date: 7.days.from_now, 
                                  max_quantity: 20, discount_percent: 5, max_discount_money: 20,
                                  sub_category_ids: [subcategory1.id, subcategory2.id]}}
    promotion = Promotion.last
    expect(promotion.name).to eq 'Promoção'
    expect(response).to redirect_to(promotion_path(promotion))
  end

  it 'sem sucesso, pois campos em branco' do
    merchant = create(:merchant)    

    login_as(merchant, scope: :merchant)
    post promotions_path, params: { promotion:{ name:'',start_date:'',end_date:'',max_quantity:'', discount_percent:'', max_discount_money:'', sub_category_ids:''}}

    result = Promotion.all.count
    expect(response).to render_template(:new)
    expect(result).to eq 0
  end

  it 'sem sucesso, pois campos inválidos' do
    merchant = create(:merchant)    

    login_as(merchant, scope: :merchant)
    post promotions_path, params: { promotion:{ name:'Super promo',start_date:'x',end_date:'',max_quantity:'-1', discount_percent:'a', max_discount_money:'0', sub_category_ids:''}}

    result = Promotion.all.count
    expect(response).to render_template(:new)
    expect(result).to eq 0
  end

  it 'e precisa estar autenticado' do
    subcategory1 = create(:sub_category)
    subcategory2 = create(:sub_category)

    post promotions_path, params: { promotion: {name: 'Promoção', start_date: Date.today, end_date: 7.days.from_now, 
                                    max_quantity: 20, discount_percent: 5, max_discount_money: 20,
                                    sub_category_ids: [subcategory1.id, subcategory2.id]}}
    
    expect(response).to redirect_to new_merchant_session_path
    result = Promotion.all.count
    expect(result).to eq 0
  end
end