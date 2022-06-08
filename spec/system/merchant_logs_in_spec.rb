require 'rails_helper'

describe 'Mercador faz login' do 
    it 'com sucesso' do 
        Merchant.create!(email:'mercador@mercadores.com.br', password:'123456', name:'Mercador')
        visit root_path

        click_on 'Entrar - Mercador'
        fill_in 'E-mail', with: 'mercador@mercadores.com.br'
        fill_in 'Senha', with: '123456'
        click_on 'Log in'
        
        expect(page).to have_content 'Login efetuado com sucesso'
        expect(page).to have_content 'Painel - Mercadores'
        
    end
    
    it 'e faz logout' do 
        merchant = Merchant.create!(email:'mercador@mercadores.com.br', password:'123456', name:'Mercador')
        login_as(merchant, scope: :merchant)

        visit root_path        
        expect(page).to have_content 'Painel - Mercadores'
        click_on 'Logout'

        expect(page).to have_content 'Logout efetuado com sucesso'
        expect(page).not_to have_content 'Painel - Mercadores'

    end
    
end