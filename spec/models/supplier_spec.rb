require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'requer presença de' do
      it 'Razão social' do
        supplier = Supplier.new(
          corporate_name: '', brand_name: 'SolTec', registration_number: '12345678000101',
          full_address: 'Rua Principal, 123', city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
        )

        expect(supplier.valid?).to be_falsey
      end
      
      it 'Nome fantasia' do
        supplier = Supplier.new(
          corporate_name: 'Soluções Tecnológicas SA', brand_name: '', registration_number: '12345678000101',
          full_address: 'Rua Principal, 123', city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
        )

        expect(supplier.valid?).to be_falsey
      end
      
      it 'Numero cnpj' do
        supplier = Supplier.new(
          corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec', registration_number: '',
          full_address: 'Rua Principal, 123', city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
        )

        expect(supplier.valid?).to be_falsey
      end
      
      it 'Endereço completo' do
        supplier = Supplier.new(
          corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec', registration_number: '12345678000101',
          full_address: '', city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
        )

        expect(supplier.valid?).to be_falsey
      end
      
      it 'Cidade' do
        supplier = Supplier.new(
          corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec', registration_number: '12345678000101',
          full_address: 'Rua Principal, 123', city: '', state: 'SP', email: 'contato@solutecltda.com.br'
        )

        expect(supplier.valid?).to be_falsey
      end
      
      it 'Estado' do
        supplier = Supplier.new(
          corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec', registration_number: '12345678000101',
          full_address: 'Rua Principal, 123', city: 'São Paulo', state: '', email: 'contato@solutecltda.com.br'
        )

        expect(supplier.valid?).to be_falsey
      end
      
      it 'Email' do
        supplier = Supplier.new(
          corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec', registration_number: '12345678000101',
          full_address: 'Rua Principal, 123', city: 'São Paulo', state: 'SP', email: ''
        )

        expect(supplier.valid?).to be_falsey
      end
    end
  end
end
