require 'rails_helper'

describe 'Usuário compra crédito de rubis' do
  it 'a partir da página de detalhes da conta' do
    customer = create(:customer)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Minha conta'
    click_on 'Comprar crédito'
    fill_in 'Valor em reais', with: 1000
    click_on 'Comprar'

    expect(page).to have_content 'Compra realizada com sucesso'
    expect(page).to have_content "Saldo disponível: #{customer.balance}"
  end
end