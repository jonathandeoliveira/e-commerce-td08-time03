require 'rails_helper'

describe 'cliente se autentica no ecommerce' do
  it 'com sucesso' do
    customer = create(:customer)

    visit root_path
    click_on 'Entrar - Clientes'
    fill_in 'E-mail', with: "#{customer.email}"
    fill_in 'Senha', with: "#{customer.password}"
    click_on 'Entrar'

    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_content 'Logout'
    expect(page).not_to have_content 'Entrar - Clientes'
  end

  it 'sem sucesso, campos inválidos' do
    customer = create(:customer)

    visit root_path
    click_on 'Entrar - Clientes'
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    click_on 'Entrar'

    expect(page).to have_content 'E-mail ou senha inválidos.'
    expect(page).not_to have_content 'Logout'
  end
end
