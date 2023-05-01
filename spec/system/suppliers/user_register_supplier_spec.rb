require 'rails_helper'


describe 'Usuário registra um novo fornecedor' do
  it 'a partir da tela inicial' do
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar fornecedor'

    expect(current_path).to eq new_supplier_path

    expect(page).to have_field 'Razão social'
    expect(page).to have_field 'Nome fantasia'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço completo'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'Email'
  end

  it 'com sucesso' do
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar fornecedor'

    fill_in 'Razão social', with: 'Alimentos Saudáveis Ltda'
    fill_in 'Nome fantasia', with: 'AlimSaudáveis'
    fill_in 'CNPJ', with: '34567890000103'
    fill_in 'Endereço completo', with: 'Rua das Flores, 789'
    fill_in 'Cidade', with: 'Florianópolis'
    fill_in 'Estado', with: 'SC'
    fill_in 'Email', with: 'contato@alimentossa.com.br'

    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor cadastrado com sucesso'
    expect(page).to have_content 'Alimentos Saudáveis Ltda (AlimSaudáveis)'
    expect(page).to have_content 'CNPJ: 34567890000103'
    expect(page).to have_content 'Endereço: Rua das Flores, 789'
    expect(page).to have_content 'Cidade: Florianópolis - SC'
    expect(page).to have_content 'Email: contato@alimentossa.com.br'
  end

  it 'com dados incoretos' do
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar fornecedor'

    fill_in 'Razão social', with: ''
    fill_in 'CNPJ', with: '34449849'
    fill_in 'Cidade', with: ''
    fill_in 'Email', with: ''

    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível cadastrar fornecedor.'
  end
end
