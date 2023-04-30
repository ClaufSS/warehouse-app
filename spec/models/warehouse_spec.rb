require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context "requer presença de" do
    
      it ' nome ' do
        warehouse = Warehouse.new(name: '', code: 'MCZ', city: 'Maceió',
                                  area: 75_000, address: 'Rua Macelino Campos, 196',
                                  cep: '05867-286', description: 'Um galpão ae')
        
        expect(warehouse).not_to be_valid

      end

      it 'código' do
        warehouse = Warehouse.new(name: 'Maceio', code: '', city: 'Maceió',
                                  area: 75_000, address: 'Rua Macelino Campos, 196',
                                  cep: '05867-286', description: 'Um galpão ae')
        
        expect(warehouse).not_to be_valid

      end

      it 'cidade' do
        warehouse = Warehouse.new(name: 'Maceio', code: 'MCZ', city: '',
                                  area: 75_000, address: 'Rua Macelino Campos, 196',
                                  cep: '05867-286', description: 'Um galpão ae')
        
        expect(warehouse).not_to be_valid

      end

      it 'endereço' do
        warehouse = Warehouse.new(name: 'Maceio', code: 'MCZ', city: 'Maceió',
                                  area: 75_000, address: '',
                                  cep: '05867-286', description: 'Um galpão ae')
        
        expect(warehouse).not_to be_valid

      end
    end

    context 'requer unicidade de' do
      it 'código' do
        Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceió',
                         area: 75_000, address: 'Rua Macelino Campos, 196',
                         cep: '05867-286', description: 'Um galpão ae')

        warehouse = Warehouse.new(name: 'Rio', code: 'MCZ', city: 'Rio de Janeiro',
                                  area: 80_000, address: 'Av do Aeroporto, 588',
                                  cep: '56466-001', description: 'Outro galpão')

        expect(warehouse).not_to be_valid
      end

      it 'nome' do
        Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceió',
          area: 75_000, address: 'Rua Macelino Campos, 196',
          cep: '05867-286', description: 'Um galpão ae')

        warehouse = Warehouse.new(name: 'Maceio', code: 'RIO', city: 'Rio de Janeiro',
                          area: 80_000, address: 'Av do Aeroporto, 588',
                          cep: '56466-001', description: 'Outro galpão')

        expect(warehouse).not_to be_valid
      end
    end

    context 'requer formato válido de' do
      it 'CEP' do
        warehouse = Warehouse.new(name: 'Maceio', code: 'MCZ', city: 'Maceió',
                         area: 75_000, address: 'Rua Macelino Campos, 196',
                         cep: '05867286', description: 'Um galpão ae')

        expect(warehouse).not_to be_valid
      end
    end
  end
end
