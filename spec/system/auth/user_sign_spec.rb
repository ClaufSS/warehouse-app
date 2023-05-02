require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    User.create!(
      email: 'claufs@gmail.com', password: 'apassword', name: 'Clauf'
    )

    visit root_path
    click_on 'Entrar'

    within 'form' do
      fill_in "E-mail",	with: "claufs@gmail.com"
      fill_in "Senha",	with: "apassword"
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_content 'Clauf'
    expect(page).not_to have_button 'Entrar'
  end

  it 'com dados incorretos' do
    visit root_path
    click_on 'Entrar'

    within 'form' do
      fill_in "E-mail",	with: "claufs@gmail.com"
      fill_in "Senha",	with: "apassword"
      click_on 'Entrar'
    end

    expect(page).to have_content 'E-mail ou senha inválidos.'
  end

  it 'faz logout' do
    User.create!(
      email: 'claufs@gmail.com', password: 'apassword', name: 'Clauf'
    )

    visit root_path
    click_on 'Entrar'

    within 'form' do
      fill_in "E-mail",	with: "claufs@gmail.com"
      fill_in "Senha",	with: "apassword"
      click_on 'Entrar'
    end

    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
  end
end
