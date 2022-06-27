require 'rails_helper'

describe 'Cliente faz request de cadastro' do
  it 'com sucesso' do
    post("/customers", params: { customer: 
      {name: 'Marina Maitê Barbosa', full_adress: 'Rua Figueiredo Teles 299, Lagoa Azul - AP',
      registration_number: '677.186.107-48', email: 'marina_maite@gmail.com', password: 'password', password_confirmation: 'password'}})
    
    expect(response).to redirect_to root_path
    expect(Customer.last.name).to eq 'Marina Maitê Barbosa'
    expect(Customer.last.registration_number).to eq '677.186.107-48'
  end

  it 'sem sucesso, pois campos inválidos' do
    post("/customers", params: { customer: 
      {name: '', full_adress: '',
      registration_number: '', email: '', password: '', password_confirmation: ''}})
        
    expect(Customer.count).to eq 0
    expect(response).to render_template('customers/registrations/new')
  end
end