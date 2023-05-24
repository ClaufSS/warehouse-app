require 'rails_helper'


describe 'Usuário edita um pedido' do
  it 'se estiver autenticado' do
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

    Supplier.create!(
      corporate_name: 'ByteWise Tecnologia Ltda', brand_name: 'ByteWise',
      registration_number: '23456789000102', full_address: 'Av. do Progresso, 456',
      city: 'Belo Horizonte', state: 'MG', email: 'contato@bytewise.com.br'
    )

    patch order_path(order), params: {order: {supplier_id: 2}}

    expect(response).to redirect_to(new_user_session_path)
  end

  it 'e não é o dono' do
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

    Supplier.create!(
      corporate_name: 'ByteWise Tecnologia Ltda', brand_name: 'ByteWise',
      registration_number: '23456789000102', full_address: 'Av. do Progresso, 456',
      city: 'Belo Horizonte', state: 'MG', email: 'contato@bytewise.com.br'
    )

    login_as(user)

    patch order_path(order), params: {order: {supplier_id: 2}}

    expect(response).to redirect_to(root_path)
  end
end