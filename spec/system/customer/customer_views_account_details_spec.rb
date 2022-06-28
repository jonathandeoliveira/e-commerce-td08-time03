require 'rails_helper'

describe 'usuário cliente acessa sua conta' do
  it 'se estiver autenticado' do
    customer = create(:customer)
    visit account_customer_path(customer)
    
    expect(current_path).to eq new_customer_session_path
  end

  it 'e vê detalhes de sua conta' do
    customer = create(:customer)
    login_as(customer, scope: :customer)
    visit root_path
    click_on customer.email

    expect(current_path).to eq account_customer_path(customer)
    expect(page).to have_content 'Detalhes da sua conta'
    expect(page).to have_content "Saldo: #{customer.balance}"
    expect(page).to have_content "Nome: #{customer.name}"
    expect(page).to have_content "CPF/CNPJ: #{customer.registration_number}"
    expect(page).to have_content "E-mail: #{customer.email}"
    expect(page).to have_content "Endereço completo: #{customer.full_adress}"
  end

  it 'e não vê detalhes de conta de outros clientes' do
    authorized_customer = create(:customer)
    unauthorized_customer = create(:customer, registration_number:'30.530.239/0001-34', balance: 2500, email: "fulano@gmail.com")
    
    login_as(authorized_customer)
    visit account_customer_path(unauthorized_customer)

    expect(current_path).not_to eq account_customer_path(unauthorized_customer)
    expect(current_path).to eq root_path
    expect(page).to have_content "Erro! Página não encontrada :("
    expect(page).not_to have_content "Saldo: #{unauthorized_customer.balance}"
    expect(page).not_to have_content "Nome: #{unauthorized_customer.name}"

  end

end
