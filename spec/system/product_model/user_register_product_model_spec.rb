require 'rails_helper'

describe 'Usuário cadastra novo modelo de produto' do
  it 'com sucesso' do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    login_as(user, :scope => :user)

    supplier = Supplier.create!(
      corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
      registration_number: '12345678000101', full_address: 'Rua Principal, 123',
      city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
    )

    visit root_path
    click_on 'Modelos de produto'
    click_on 'Cadastrar modelo'

    fill_in 'Nome',	with: 'Impressora Multifuncional'
    fill_in 'Peso',	with: '8_500'
    fill_in 'Largura',	with: '20'
    fill_in 'Altura',	with: '350'
    fill_in 'Profundidade',	with: '150'
    fill_in 'SKU',	with: 'ST-03'
    select 'SolTec', from: 'Fornecedor'

    click_on 'Enviar'

    expect(page).to have_content 'Impressora Multifuncional'
    expect(page).to have_content 'Fornecedor: SolTec'
    expect(page).to have_content 'Peso: 8500g'
    expect(page).to have_content 'Dimensão: 20mm x 350mm x 150mm'
    expect(page).to have_content 'SKU: ST-03'
  end

  it 'com informações incorretas' do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    login_as(user, :scope => :user)
    
    Supplier.create!(
      corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
      registration_number: '12345678000101', full_address: 'Rua Principal, 123',
      city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
    )
    
    visit root_path
    click_on 'Modelos de produto'
    click_on 'Cadastrar modelo'

    fill_in 'Nome',	with: ''
    fill_in 'Largura',	with: ''
    fill_in 'SKU',	with: ''

    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível criar modelo de produto'
  end
end
