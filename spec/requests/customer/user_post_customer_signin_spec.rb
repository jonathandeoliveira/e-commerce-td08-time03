require 'rails_helper'

describe 'Cliente faz request de login' do

  it 'com sucesso' do
    customer = create(:customer)

    post customer_session_path( params: {customer: {email: customer.email, password: customer.password }})

    expect(response).to redirect_to root_path
  end

  it 'com campos em branco' do

    post customer_session_path( params: {customer: {email: '', password: '' }})

    expect(response).to render_template('customers/sessions/new')
  end
end