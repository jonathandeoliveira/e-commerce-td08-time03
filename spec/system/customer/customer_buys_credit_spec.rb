require 'rails_helper'

describe 'Usuário compra crédito de rubis' do
  it 'a partir da página de detalhes da conta com sucesso' do
    customer = create(:customer)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Minha conta'
    click_on 'Comprar crédito'
    fill_in 'Valor em reais', with: 1000
    click_on 'Comprar'
    # response = double('faraday_response', body: json, status: 200)
    # Allow(Faraday).to receive(:post).and_return(response)
    customer.reload
    expect(page).to have_content 'Solicitação de créditos realizada com sucesso'
  end
end
