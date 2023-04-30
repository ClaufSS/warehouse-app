require 'rails_helper'


describe 'Usuário edita um fornecedor' do
  it 'a partir da tela inicial' do
    Supplier.create!(
      corporate_name: 'Sabores Deliciosos SA', brand_name: 'SaboresDeliciosos',
      registration_number: '45678901000104', full_address: 'Av. da Praia, 987',
      city: 'Rio de Janeiro', state: 'RJ', email: 'contato@saboresdeliciosos.com.br'
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'SaboresDeliciosos'
    click_on 'Editar'

    expect(page).to have_field 'Razão social', with: 'Sabores Deliciosos SA'
    expect(page).to have_field 'Nome fantasia', with: 'SaboresDeliciosos'
    expect(page).to have_field 'CNPJ', with: '45678901000104'
    expect(page).to have_field 'Endereço completo', with: 'Av. da Praia, 987'
    expect(page).to have_field 'Cidade', with: 'Rio de Janeiro'
    expect(page).to have_field 'Estado', with: 'RJ'
    expect(page).to have_field 'Email', with: 'contato@saboresdeliciosos.com.br'
  end

  it 'com sucesso' do
    Supplier.create!(
      corporate_name: 'Sabores Deliciosos SA', brand_name: 'SaboresDeliciosos',
      registration_number: '45678901000104', full_address: 'Av. da Praia, 987',
      city: 'Rio de Janeiro', state: 'RJ', email: 'contato@saboresdeliciosos.com.br'
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'SaboresDeliciosos'
    click_on 'Editar'
    
    expect(page).to have_field 'Nome fantasia', with: 'Deliciosos'
    expect(page).to have_field 'Endereço completo', with: 'Av. da Praia, 789'
    expect(page).to have_field 'Cidade', with: 'Florianópolis'
    expect(page).to have_field 'Estado', with: 'SC'

    click_on 'Enviar'

    expect(current_path).to eq suppliers_path

    expect(page).to have_content 'Fornecedor cadastrado com sucesso'
    expect(page).to have_content 'Deliciosos'
    expect(page).to have_content 'Florianópolis - SC'
  end

  it 'com dados incoretos' do
    Supplier.create!(
      corporate_name: 'Sabores Deliciosos SA', brand_name: 'SaboresDeliciosos',
      registration_number: '45678901000104', full_address: 'Av. da Praia, 987',
      city: 'Rio de Janeiro', state: 'RJ', email: 'contato@saboresdeliciosos.com.br'
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'SaboresDeliciosos'
    click_on 'Editar'

    fill_in 'Razão social', with: ''
    fill_in 'CNPJ', with: '34449849'
    fill_in 'Cidade', with: ''
    fill_in 'Email', with: ''

    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível cadastrar fornecedor.'
  end
end
