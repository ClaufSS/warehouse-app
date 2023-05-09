require 'rails_helper'

describe "Usuário acessa 'meus pedidos'" do
  it 'se estiver autenticado' do
    visit root_path

    expect(current_path).to eq new_user_session_path
    expect(page).not_to have_link 'Meus Pedidos'
  end

  it 'a partir do menu' do
    user = User.create!(
      name: 'Marcel', email: 'marcel@gmail.com', password: 'f4k3p455w0rd'
    )

    login_as(user)

    visit root_path

    within 'nav' do
      expect(page).to have_link 'Meus Pedidos'
    end
  end

  it 'e vê pedidos' do
    user = User.create!(
      name: 'Marcel', email: 'marcel@gmail.com', password: 'f4k3p455w0rd'
    )
    
    first_warehouse = Warehouse.create!(
      name: 'Maceio', code: 'MCZ', city: 'Maceió', area: 75_000,
      address: 'Rua Macelino Campos, 196', cep: '05867-286', description: 'Galpão de Maceio'
    )
    second_warehouse = Warehouse.create!(
      name: 'Aeroporto Guarulhos', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida Aeroporto, 1000', cep: '00045-779',
      description: 'Galpão destinado para cargas internacionais'
    )

    first_supplier = Supplier.create!(
      corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
      registration_number: '12345678901234', full_address: 'Rua Principal, 123',
      city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
    )
    second_supplier = Supplier.create!(
      corporate_name: 'ByteWise Tecnologia Ltda', brand_name: 'ByteWise',
      registration_number: '23456789000102', full_address: 'Av. do Progresso, 456',
      city: 'Belo Horizonte', state: 'MG', email: 'contato@bytewise.com.br'
    )

    fisrt_order = Order.create!(
      warehouse: first_warehouse, supplier: first_supplier, user: user,
      expected_delivery_date: 1.day.from_now
    )
    second_order = Order.create!(
      warehouse: second_warehouse, supplier: second_supplier, user: user,
      expected_delivery_date: 2.day.from_now
    )
  
    login_as(user)
  
    visit root_path
  
    within 'nav' do
      click_on 'Meus Pedidos'
    end
  
    expect(page).to have_content "Pedido: #{fisrt_order.code}"
    expect(page).to have_content 'Galpão de destino: MCZ - Maceio'
    expect(page).to have_content 'Fornecedor: Soluções Tecnológicas SA - SolTec'
    expect(page).to have_content 'Usuário do pedido: Marcel'
    expect(page).to have_content "Previsão de entraga: #{I18n.l 1.day.from_now.to_date}"

    expect(page).to have_content "Pedido: #{second_order.code}"
    expect(page).to have_content 'Galpão de destino: GRU - Aeroporto Guarulhos'
    expect(page).to have_content 'Fornecedor: ByteWise Tecnologia Ltda - ByteWise'
    expect(page).to have_content 'Usuário do pedido: Marcel'
    expect(page).to have_content "Previsão de entraga: #{I18n.l 2.day.from_now.to_date}"
  end


  it 'e não vê pedidos de outros usuários' do
    user = User.create!(
      name: 'Marcel', email: 'marcel@gmail.com', password: 'f4k3p455w0rd'
    )
    another_user = User.create!(
      name: 'Antonio', email: 'antonio@gmail.com', password: 'f4k3p455w0rd'
    )

    first_warehouse = Warehouse.create!(
      name: 'Maceio', code: 'MCZ', city: 'Maceió', area: 75_000,
      address: 'Rua Macelino Campos, 196', cep: '05867-286', description: 'Galpão de Maceio'
    )
    second_warehouse = Warehouse.create!(
      name: 'Aeroporto Guarulhos', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida Aeroporto, 1000', cep: '00045-779',
      description: 'Galpão destinado para cargas internacionais'
    )

    first_supplier = Supplier.create!(
      corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
      registration_number: '12345678901234', full_address: 'Rua Principal, 123',
      city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
    )
    second_supplier = Supplier.create!(
      corporate_name: 'ByteWise Tecnologia Ltda', brand_name: 'ByteWise',
      registration_number: '23456789000102', full_address: 'Av. do Progresso, 456',
      city: 'Belo Horizonte', state: 'MG', email: 'contato@bytewise.com.br'
    )

    fisrt_order = Order.create!(
      warehouse: first_warehouse, supplier: first_supplier, user: user,
      expected_delivery_date: 1.day.from_now
    )
    second_order = Order.create!(
      warehouse: second_warehouse, supplier: second_supplier, user: another_user,
      expected_delivery_date: 2.day.from_now
    )

    login_as(user)

    visit root_path

    within 'nav' do
      click_on 'Meus Pedidos'
    end

    expect(page).to have_content "Pedido: #{fisrt_order.code}"
    expect(page).to have_content 'Galpão de destino: MCZ - Maceio'
    expect(page).to have_content 'Fornecedor: Soluções Tecnológicas SA - SolTec'
    expect(page).to have_content 'Usuário do pedido: Marcel'
    expect(page).to have_content "Previsão de entraga: #{I18n.l 1.day.from_now.to_date}"

    expect(page).to have_content "Pedido: #{second_order.code}"
    expect(page).to have_content 'Galpão de destino: GRU - Aeroporto Guarulhos'
    expect(page).to have_content 'Fornecedor: ByteWise Tecnologia Ltda - ByteWise'
    expect(page).to have_content 'Usuário do pedido: Antonio'
    expect(page).to have_content "Previsão de entraga: #{I18n.l 2.day.from_now.to_date}"
  end

  it 'e não tem pedidos' do
    user = User.create!(
      name: 'Marcel', email: 'marcel@gmail.com', password: 'f4k3p455w0rd'
    )
  
    login_as(user)

    visit root_path

    within 'nav' do
      click_on 'Meus Pedidos'
    end

    expect(page).to have_content 'Você não tem pedidos cadastrados.'
  end
end
