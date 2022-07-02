require 'rails_helper'

describe 'Usuário compra crédito de rubis' do
  it 'a partir da página de detalhes da conta sem sucesso, pois não possui conexão com a aplicação de pagamentos' do
    customer = create(:customer)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Minha conta'
    click_on 'Comprar crédito'
    fill_in 'Valor em reais', with: 1000
    click_on 'Comprar'

    customer.reload
    expect(page).to have_content 'Falha na solicitação, tente novamente mais tarde'
  end
end
