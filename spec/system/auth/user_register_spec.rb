require 'rails_helper'

describe 'Usuário cria conta' do
  it 'com sucesso' do
    visit root_path
    click_on 'Criar conta'

    within 'main form' do
      fill_in "Nome",	with: "Jorginho"
      fill_in "E-mail",	with: "jorginhos@gmail.com"
      fill_in "Senha",	with: "apassword"
      fill_in "Confirme sua senha",	with: "apassword"
      click_on 'Criar conta'
    end

    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Jorginho'
    expect(page).not_to have_content 'Criar conta'
  end
end
