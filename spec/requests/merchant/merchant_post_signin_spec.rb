require 'rails_helper'

describe 'mercador faz request de login' do
  it 'com sucesso' do
    customer = create(:merchant)

    post merchant_session_path( params: {merchant: {email: customer.email, password: customer.password }})

    expect(response).to redirect_to root_path
  end

  it 'sem sucesso, pois campos em branco' do
    post merchant_session_path( params: {merchant: {email: '', password: '' }})

    expect(response).to render_template('devise/sessions/new')
  end
end