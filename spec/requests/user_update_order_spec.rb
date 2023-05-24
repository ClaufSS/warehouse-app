require 'rails_helper'


describe 'Usuário atualiza status do pedido' do
  context 'e marca como entregue' do
    before :each do
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
      @order = Order.create!(
        warehouse: warehouse, supplier: supplier, user: user,
        expected_delivery_date: 1.day.from_now
      )
    end


    it 'se estiver autenticado' do
      post delivered_order_path(@order)

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'e deve ser o dono do pedido' do
      another_user = User.create!(
        name: 'Andre', email: 'andre@gmail.com', password: 'f4k3p455w0rd'
      )

      login_as(another_user)

      post delivered_order_path(@order)

      expect(response).to redirect_to(root_path)
    end
  end


  context 'e marca como cancelado' do
    before :each do
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
      @order = Order.create!(
        warehouse: warehouse, supplier: supplier, user: user,
        expected_delivery_date: 1.day.from_now
      )
    end


    it 'se estiver autenticado' do
      post canceled_order_path(@order)

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'e deve ser o dono do pedido' do
      another_user = User.create!(
        name: 'Andre', email: 'andre@gmail.com', password: 'f4k3p455w0rd'
      )

      login_as(another_user)

      post canceled_order_path(@order)

      expect(response).to redirect_to(root_path)
    end
  end

end