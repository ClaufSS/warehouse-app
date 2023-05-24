require 'rails_helper'


describe 'Usuário informa novo status do pedido' do
  it 'e pedido foi entregue' do
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
    visit order_path(order)

    click_on 'Marcar como ENTREGUE'

    expect(page).to have_content 'Status: Entregue'
    expect(page).not_to have_content 'Status: Pendente'
  end

  it 'e pedido foi cancelado' do
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
    visit order_path(order)

    click_on 'Marcar como CANCELADO'

    expect(page).to have_content 'Status: Cancelado'
    expect(page).not_to have_content 'Status: Entregue'
    expect(page).not_to have_content 'Status: Pendente'
  end
end