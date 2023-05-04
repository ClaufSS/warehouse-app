require 'rails_helper'

describe 'Usuário se autentica' do
  before :each do
    User.create!(
      email: 'jorginhos@gmail.com', password: 'apassword', name: 'Jorginho'
    )
  end
  
  it 'com sucesso' do
    visit new_user_session_path

    within 'form' do
      fill_in 'E-mail',	with: 'jorginhos@gmail.com'
      fill_in 'Senha',	with: 'apassword'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_content 'Jorginho'
    expect(page).not_to have_button 'Entrar'
  end

  it 'com dados incorretos' do
    visit new_user_session_path

    within 'form' do
      fill_in 'E-mail',	with: 'jorginhos@gmail.com'
      fill_in 'Senha',	with: 'otherpassword'
      click_on 'Entrar'
    end

    expect(page).to have_content 'E-mail ou senha inválidos.'
  end

  it 'e faz logout' do
    visit new_user_session_path

    within 'form' do
      fill_in 'E-mail',	with: 'jorginhos@gmail.com'
      fill_in 'Senha',	with: 'apassword'
      click_on 'Entrar'
    end

    click_on 'Sair'

    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(current_path).to eq new_user_session_path
  end
end
