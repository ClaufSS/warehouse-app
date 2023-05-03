require 'rails_helper'

describe 'Usuário vê modelos de produto' do
  it 'se estiver autenticado' do
    visit root_path
    
    within 'nav' do
      click_on 'Modelos de produto'
    end

    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu' do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    login_as(user, :scope => :user)

    visit root_path
    
    within 'nav' do
      click_on 'Modelos de produto'
    end

    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    login_as(user, :scope => :user)

    supplier = Supplier.create!(
      corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
      registration_number: '12345678000101', full_address: 'Rua Principal, 123',
      city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
    )

    ProductModel.create!(
      name: 'Monitor LED 24 polegadas', weight: 3500, width:55,
      height: 350, depth: 100, sku: 'ST-01ML24P0000000001', supplier: supplier
    )

    visit root_path

    within 'nav' do
      click_on 'Modelos de produto'
    end

    expect(page).to have_content 'Monitor LED 24 polegadas'
    expect(page).to have_content 'ST-01ML24P0000000001'
    expect(page).to have_content 'SolTec'
  end
  
  it 'não existem modelos cadastrados' do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    login_as(user, :scope => :user)
    
    visit root_path

    within 'nav' do
      click_on 'Modelos de produto'
    end

    expect(page).to have_content 'Não existe nenhum modelo de produto cadastrado.'
  end
end
