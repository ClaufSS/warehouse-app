require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'se estiver autenticado' do
    visit root_path

    expect(current_path).to eq new_user_session_path
    expect(page).not_to have_field 'Buscar pedido'
    expect(page).not_to have_button 'Buscar'    
  end

  it 'a partir do menu' do
    user = User.create!(
      name: 'Marcel', email: 'marcel@gmail.com', password: 'f4k3p455w0rd'
    )

    login_as(user)

    visit root_path

    within "header nav form[action='/orders/search']" do
      expect(page).to have_field 'Buscar pedido'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'a partir do menu' do
    user = User.create!(
      name: 'Marcel', email: 'marcel@gmail.com', password: 'f4k3p455w0rd'
    )

    login_as(user)

    visit root_path

    within 'nav' do
      expect(page).to have_field 'Buscar pedido'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'se estiver autenticado' do
    visit root_path

    expect(current_path).to eq new_user_session_path
  end

  context 'usando código' do
    context 'parcial' do
      it 'e há varias correspondências' do
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
  
        allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABCDEFG890')
  
        Order.create!(
          warehouse: first_warehouse, supplier: first_supplier, user: user,
          expected_delivery_date: 1.day.from_now
        )
  
        allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABCDEFGH90')
  
        Order.create!(
          warehouse: second_warehouse, supplier: second_supplier, user: user,
          expected_delivery_date: 2.day.from_now
        )
  
        login_as(user)
  
        visit root_path
  
        within 'nav' do
          fill_in 'Buscar pedido',	with: 'ABCDEFG'
          click_on 'Buscar'
        end
  
        expect(page).to have_content "2 pedidos encontrados para: ABCDEFG"
  
        expect(page).to have_content "Código do pedido: ABCDEFG890"
        expect(page).to have_content 'Galpão destino: MCZ - Maceio'
        expect(page).to have_content 'Fornecedor: Soluções Tecnológicas SA - SolTec'
  
        expect(page).to have_content "Código do pedido: ABCDEFG890"
        expect(page).to have_content 'Galpão destino: GRU - Aeroporto Guarulhos'
        expect(page).to have_content 'Fornecedor: ByteWise Tecnologia Ltda - ByteWise'
      end

      it 'e há apenas uma correspondência' do
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

        allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABCDEFG890')

        Order.create!(
          warehouse: warehouse, supplier: supplier, user: user,
          expected_delivery_date: 1.day.from_now
        )
  
        login_as(user)
  
        visit root_path
  
        within 'nav' do
          fill_in 'Buscar pedido',	with: 'ABCDEF'
          click_on 'Buscar'
        end

        expect(page).to have_content 'Galpão de destino: MCZ - Maceio'
        expect(page).to have_content 'Fornecedor: Soluções Tecnológicas SA - SolTec'
        expect(page).to have_content 'Usuário do pedido: Marcel'
        expect(page).to have_content "Data prevista de entrega: #{I18n.localize 1.day.from_now.to_date}"
      end
    end

    it 'completo' do
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

      visit root_path

      within 'nav' do
        fill_in 'Buscar pedido',	with: order.code
        click_on 'Buscar'
      end

      expect(page).to have_content 'Galpão de destino: MCZ - Maceio'
      expect(page).to have_content 'Fornecedor: Soluções Tecnológicas SA - SolTec'
      expect(page).to have_content 'Usuário do pedido: Marcel'
      expect(page).to have_content "Data prevista de entrega: #{I18n.localize 1.day.from_now.to_date}"
    end

    it 'e não há correspondência' do
      user = User.create!(
        name: 'Marcel', email: 'marcel@gmail.com', password: 'f4k3p455w0rd'
      )

      login_as(user)

      visit root_path

      within 'nav' do
        fill_in 'Buscar pedido',	with: 'ABC4567890'
        click_on 'Buscar'
      end

      expect(page).to have_content 'Não foi encontrado correspondência para: ABC4567890'
    end
  end
end
