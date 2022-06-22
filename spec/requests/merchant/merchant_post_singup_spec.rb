require 'rails_helper'

describe 'mercador faz request de cadastro' do
  it 'com sucesso' do
    post("/merchants", params: { merchant: {name: 'Marina Maitê Barbosa', email: 'marina_maite@mercadores.com.br', password: 'password', password_confirmation: 'password'}})
    
    expect(response).to redirect_to root_path
    expect(Merchant.last.name).to eq 'Marina Maitê Barbosa'
    expect(Merchant.last.email).to eq 'marina_maite@mercadores.com.br'
  end

  it 'com campos em branco' do
    post("/merchants", params: { merchant: {name: '', email: '', password: '', password_confirmation: ''}})
      
  expect(Merchant.count).to eq 0
  expect(response).to render_template('devise/registrations/new')
  end
end