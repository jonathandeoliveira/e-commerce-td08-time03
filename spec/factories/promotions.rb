
FactoryBot.define do
  factory :promotion, class: 'promotion' do
    name { "Super Promoção" }
    code { '8DIGITOS' }
    start_date { Date.today }
    end_date { 3.weeks.from_now }
    max_quantity { 20 }
    used_quantity { 0 }
    status { 1 }    
    discount_percent { 5 }
    max_discount_money { "0.40"  }
    #association :sub_category, factory: :sub_category
    #sub_category
  end
end
