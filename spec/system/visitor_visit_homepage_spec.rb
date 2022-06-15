require 'rails_helper'

describe 'Visitante visita a app' do
  it 'com sucesso' do
    visit root_path

    expect(status_code).to eq 200
    expect(page).to have_content 'E-Commerce'
  end
end
