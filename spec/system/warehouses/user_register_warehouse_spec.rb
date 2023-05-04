require 'rails_helper'


describe 'Usuário cadastra um novo galpão' do
  before :each do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    login_as(user, :scope => :user)
  end

  
  it 'a partir da tela inicial' do

    visit root_path
    click_on 'Cadastrar galpão'

    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Código'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Área'
  end

  it 'com sucesso' do
    visit root_path
    click_on 'Cadastrar galpão'

    fill_in "Nome",	with: "Aeroporto Aracaju"
    fill_in "Código",	with: "AJU"
    fill_in "Cidade",	with: "Aracaju"
    fill_in "Endereço",	with: "Rua do Aeroporto internacional"
    fill_in "CEP",	with: "58791-550"
    fill_in "Área",	with: "950000"
    fill_in "Descrição",	with: "Aeroporto internacional de Aracaju"

    click_on 'Enviar'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão cadastrado com sucesso'
    expect(page).to have_content 'Aeroporto Aracaju'
    expect(page).to have_content 'AJU'
    expect(page).to have_content '950.000 m2' 
  end

  it 'com dados incorretos' do
    visit root_path
    click_on 'Cadastrar galpão'

    fill_in "Nome",	with: ""
    fill_in "Código",	with: "AJU"
    fill_in "Endereço",	with: ""
    fill_in "CEP",	with: ""
    fill_in "Área",	with: "950000"

    click_on 'Enviar'

    expect(page).to have_content 'Galpão não cadastrado'
  end
end
