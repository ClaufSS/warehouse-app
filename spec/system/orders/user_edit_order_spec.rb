require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'se estiver autenticado' do
    user = User.create!(
      name: 'Marcel', email: 'marcel@gmail.com', password: 'f4k3p455w0rd'
    )
    warehouse = Warehouse.create!(
      name: 'Maceio', code: 'MCZ', city: 'Maceió', area: 75_000,
      address: 'Rua Macelino Campos, 196', cep: '05867-286', description: 'Galpão de Maceio'
    )
    supplier = Supplier.create!(
      corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
      registration_number: '12345678901234', full_address: 'Rua Principal, 123',
      city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
    )
    order = Order.create!(
      warehouse: warehouse, supplier: supplier, user: user,
      expected_delivery_date: 1.day.from_now
    )

    visit edit_order_path(order)

    expect(current_path).to eq new_user_session_path
  end

  it 'a partir de meus pedidos' do
    user = User.create!(
      name: 'Marcel', email: 'marcel@gmail.com', password: 'f4k3p455w0rd'
    )
    warehouse = Warehouse.create!(
      name: 'Maceio', code: 'MCZ', city: 'Maceió', area: 75_000,
      address: 'Rua Macelino Campos, 196', cep: '05867-286', description: 'Galpão de Maceio'
    )
    supplier = Supplier.create!(
      corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
      registration_number: '12345678901234', full_address: 'Rua Principal, 123',
      city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
    )
    order = Order.create!(
      warehouse: warehouse, supplier: supplier, user: user,
      expected_delivery_date: 1.day.from_now
    )

    login_as(user)

    visit orders_path
    click_on order.code
    click_on 'Editar'

    expect(current_path).to eq edit_order_path(order)
  end

  it 'com sucesso' do
    user = User.create!(
      name: 'Marcel', email: 'marcel@gmail.com', password: 'f4k3p455w0rd'
    )
    warehouse = Warehouse.create!(
      name: 'Maceio', code: 'MCZ', city: 'Maceió', area: 75_000,
      address: 'Rua Macelino Campos, 196', cep: '05867-286', description: 'Galpão de Maceio'
    )
    supplier = Supplier.create!(
      corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
      registration_number: '12345678901234', full_address: 'Rua Principal, 123',
      city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
    )
    order = Order.create!(
      warehouse: warehouse, supplier: supplier, user: user,
      expected_delivery_date: 1.day.from_now
    )

    Supplier.create!(
      corporate_name: 'ByteWise Tecnologia Ltda', brand_name: 'ByteWise',
      registration_number: '23456789000102', full_address: 'Av. do Progresso, 456',
      city: 'Belo Horizonte', state: 'MG', email: 'contato@bytewise.com.br'
    )

    login_as(user)

    visit orders_path
    click_on order.code
    click_on 'Editar'

    save_page page.body

    select 'ByteWise Tecnologia Ltda - ByteWise', from: 'Fornecedor'
    fill_in 'Data prevista de entrega',	with: 5.days.from_now

    click_on 'Salvar'

    expect(page).to have_content 'Fornecedor: ByteWise'
    expect(page).to have_content "Data prevista de entrega: #{I18n.l 5.days.from_now.to_date}"
  end

  it 'caso seja o responsável' do
    user = User.create!(
      name: 'Marcel', email: 'marcel@gmail.com', password: 'f4k3p455w0rd'
    )
    another_user = User.create!(
      name: 'Andre', email: 'andre@gmail.com', password: 'f4k3p455w0rd'
    )
    warehouse = Warehouse.create!(
      name: 'Maceio', code: 'MCZ', city: 'Maceió', area: 75_000,
      address: 'Rua Macelino Campos, 196', cep: '05867-286', description: 'Galpão de Maceio'
    )
    supplier = Supplier.create!(
      corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
      registration_number: '12345678901234', full_address: 'Rua Principal, 123',
      city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
    )
    order = Order.create!(
      warehouse: warehouse, supplier: supplier, user: another_user,
      expected_delivery_date: 1.day.from_now
    )

    login_as(user)

    visit edit_order_path(order)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Acesso não permitido.'
  end
end
