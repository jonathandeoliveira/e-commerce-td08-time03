require 'rails_helper'

describe 'Usuário acessa rota não autorizada' do
  it 'e não tem acesso a ela' do

    get '/product_models'

    expect(response).to redirect_to '/merchants/sign_in'
  end
end