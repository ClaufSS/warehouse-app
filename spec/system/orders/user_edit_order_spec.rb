require 'rails_helper'

describe 'Usuário edita pedido' do
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
    click_on 'ABCDEFG890'
    click_on 'Editar'

    expect(current_path).to eq edit_order_path(order)
  end

  it 'com sucesso' do
    //
  end
end
