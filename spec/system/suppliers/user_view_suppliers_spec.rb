require 'rails_helper'


describe 'Usuário navega até página de fornecedores' do
  before :each do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    login_as(user, :scope => :user)
  end

  
  it 'a partir do menu' do
    visit root_path
    click_on 'Fornecedores'

    expect(current_path).to eq suppliers_path
  end

  it 'e vê fornecedores cadastrados' do
    Supplier.create!(
      corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
      registration_number: '12345678000101', full_address: 'Rua Principal, 123',
      city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
    )

    Supplier.create!(
      corporate_name: 'ByteWise Tecnologia Ltda', brand_name: 'ByteWise',
      registration_number: '23456789000102', full_address: 'Av. do Progresso, 456',
      city: 'Belo Horizonte', state: 'MG', email: 'contato@bytewise.com.br'
    )

    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content 'Fornecedores'
    expect(page).to have_content 'SolTec'
    expect(page).to have_content 'São Paulo - SP'
    expect(page).to have_content 'ByteWise'
    expect(page).to have_content 'Belo Horizonte - MG'
  end

  it 'e não existem fornecedores cadastrados' do
    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content 'Não existem fornecedores cadastrados.'
  end
end
