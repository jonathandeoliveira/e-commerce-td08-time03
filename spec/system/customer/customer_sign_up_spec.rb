require 'rails_helper'

describe 'cliente se registra no ecommerce' do
  it 'com sucesso' do
    visit root_path
    click_on 'Entrar - Clientes'
    click_on 'Cadastrar-se'
    fill_in 'Nome', with: 'Allan de Souza'
    fill_in 'E-mail', with: 'allan@gmail.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    fill_in 'CPF/CNPJ', with: '704.066.280-92'
    fill_in 'Endereço completo', with: 'Rua Picos 240, Queimadinha, Feira de Santana, BA'
    click_on "Cadastrar-se"

    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(page).not_to have_content 'Entrar - Clientes'
    expect(page).to have_button 'Logout'
    customer = Customer.last
    expect(customer.email).to eq 'allan@gmail.com'
    expect(customer.name).to eq 'Allan de Souza'
    expect(customer.registration_number).to eq '704.066.280-92'
    expect(customer.full_adress).to eq 'Rua Picos 240, Queimadinha, Feira de Santana, BA'
  end

  it 'com campos em branco' do
    visit root_path
    click_on 'Entrar - Clientes'
    click_on 'Cadastrar-se'
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirme sua senha', with: ''
    fill_in 'CPF/CNPJ', with: ''
    fill_in 'Endereço completo', with: ''
    click_on "Cadastrar-se"

    expect(page).to have_content 'Não foi possível salvar cliente: 6 erros.'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Endereço completo não pode ficar em branco'
    expect(page).to have_content 'CPF/CNPJ não pode ficar em branco'
    expect(page).to have_content 'CPF/CNPJ possui formato inválido'
    expect(Customer.count).to eq 0
  end
end