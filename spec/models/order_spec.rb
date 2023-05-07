require 'rails_helper'

RSpec.describe Order, type: :model do
  context '#valid?' do
    it 'deve ter um código' do
      warehouse = Warehouse.create!(
        name: 'Maceio', code: 'MCZ', city: 'Maceió', area: 75_000,
        address: 'Rua Macelino Campos, 196', cep: '05867-286', description: 'Galpão de Maceio'
      )
      supplier = Supplier.create!(
        corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
        registration_number: '12345678901234', full_address: 'Rua Principal, 123',
        city: 'São Paulo', state: 'SP', email: 'contatosolutecltda.com.br'
      )
      user = User.create!(
        name: 'Marcel', email: 'marcel@gmail.com', password: 'f4k3p455w0rd'
      )

      order = Order.create!(
        warehouse: warehouse, supplier: supplier, user: user,
        expected_delivery_date: 1.day.from_now)

      expect(order.errors[:code]).to be_empty
    end

    it 'se data não estiver no passado' do
      order = Order.new(expected_delivery_date: 1.day.ago)

      order.valid?
      expect(order.errors[:expected_delivery_date]).not_to be_empty
    end

    it 'se data não for atual' do
      order = Order.new(expected_delivery_date: Date.today)

      order.valid?
      expect(order.errors[:expected_delivery_date]).not_to be_empty
    end

    it 'se data for futura' do
      order = Order.new(expected_delivery_date: 1.day.from_now)

      order.valid?
      expect(order.errors[:expected_delivery_date]).to be_empty
    end
  end

  context '#code' do
    before :each do
      @warehouse = Warehouse.create!(
        name: 'Maceio', code: 'MCZ', city: 'Maceió', area: 75_000,
        address: 'Rua Macelino Campos, 196', cep: '05867-286', description: 'Galpão de Maceio'
      )
      @supplier = Supplier.create!(
        corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
        registration_number: '12345678901234', full_address: 'Rua Principal, 123',
        city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
      )
      @user = User.create!(
        name: 'Marcel', email: 'marcel@gmail.com', password: 'f4k3p455w0rd'
      )
    end


    it 'deve ser gerado automaticamente' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC1234567')

      order = Order.create!(
        warehouse: @warehouse, supplier: @supplier, user: @user,
        expected_delivery_date: 1.day.from_now)

      order.valid?

      expect(order.code).to eq 'ABC1234567'
    end

    it 'deve ter 10 caracteres' do
      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABC1234567')

      order = Order.create!(
        warehouse: @warehouse, supplier: @supplier, user: @user,
        expected_delivery_date: 1.day.from_now)

      order.valid?

      expect(order.code).to eq 'ABC1234567'
    end

    it 'não deve repetir' do
      order = Order.create!(
        warehouse: @warehouse, supplier: @supplier, user: @user,
        expected_delivery_date: 1.day.from_now)

    end
  end
end
