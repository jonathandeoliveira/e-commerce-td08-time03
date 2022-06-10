require 'rails_helper'

describe 'mercador se registra no ecommerce' do
  it 'com sucesso se o domínio de email for válido' do
    visit root_path
    click_on 'Entrar - Mercador'
    click_on 'Cadastre-se'

    fill_in 'Nome', with: 'José Paulo'
    fill_in 'E-mail', with: 'josepaulo@mercadores.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Enviar'

    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
  end

  it 'com falha se domínio de email for inválido' do
    visit root_path
    click_on 'Entrar - Mercador'
    click_on 'Cadastre-se'

    fill_in 'Nome', with: 'José Paulo'
    fill_in 'E-mail', with: 'jose_paulo@hotmail.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Enviar'

    expect(page).not_to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Domínio de email inválido.'
  end
end