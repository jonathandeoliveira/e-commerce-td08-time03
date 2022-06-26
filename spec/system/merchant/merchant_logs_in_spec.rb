require 'rails_helper'

describe 'Mercador faz login' do
  it 'com sucesso' do
    merchant = create(:merchant)

    visit root_path
    click_on 'Entrar - Mercador'
    fill_in 'E-mail', with: 'alan@mercadores.com.br'
    fill_in 'Senha', with: 'password'
    click_on 'Log in'

    expect(page).to have_content 'Login efetuado com sucesso'
  end

  it 'com login inexistente' do
    visit root_path
    click_on 'Entrar - Mercador'
    fill_in 'E-mail', with: 'john@mercadores.com.br'
    fill_in 'Senha', with: 'password'
    click_on 'Log in'

    expect(page).to have_content 'E-mail ou senha inválidos.'
  end

  it 'com senha incorreta' do
    merchant = create(:merchant)

    visit root_path
    click_on 'Entrar - Mercador'
    fill_in 'E-mail', with: 'alan@mercadores.com.br'
    fill_in 'Senha', with: 'wrong-password'
    click_on 'Log in'

    expect(page).to have_content 'E-mail ou senha inválidos.'
  end

  it 'e faz logout' do
    merchant = create(:merchant)

    login_as(merchant, scope: :merchant)
    visit root_path
    click_on 'Logout'

    expect(page).to have_content 'Logout efetuado com sucesso'
  end
end
