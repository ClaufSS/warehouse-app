require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do
  it 'a partir da tela inicial' do
    supplier = Supplier.create!(
      corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
      registration_number: '12345678000101', full_address: 'Rua Principal, 123',
      city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'SolTec'

    expect(page).to eq supplier_path(supplier)
  end
  
  it 'com sucesso' do
    Supplier.create!(
      corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
      registration_number: '12345678000101', full_address: 'Rua Principal, 123',
      city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'SolTec'

    expect(page).to have_content 'Razão social: Soluções Tecnológicas SA'
    expect(page).to have_content 'Nome fantasia: SolTec'
    expect(page).to have_content 'CNPJ: 12345678000101'
    expect(page).to have_content 'Endereço completo: Rua Principal, 123'
    expect(page).to have_content 'Cidade: São Paulo'
    expect(page).to have_content 'Estado: SP'
    expect(page).to have_content 'Email: contato@solutecltda.com.br'
  end
  
  it 'e volta para tela inicial' do
    Supplier.create!(
      corporate_name: 'ByteWise Tecnologia Ltda', brand_name: 'ByteWise',
      registration_number: '23.456.789/0001-02', full_address: 'Av. do Progresso, 456',
      city: 'Belo Horizonte', state: 'MG', email: 'contato@bytewise.com.br'
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'SolTec'
    click_on 'Home'

    expect(page).to eq root_path
  end
end
