require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context "present" do
    
      it 'false quando campo -nome- está vazio' do
        warehouse = Warehouse.new(name: '', code: 'MCZ', city: 'Maceió',
                                  area: 75_000, address: 'Rua Macelino Campos, 196',
                                  cep: '05867-286', description: 'Um galpão ae')
        
        expect(warehouse).not_to be_valid

      end

      it 'false quando campo -código- está vazio' do
        warehouse = Warehouse.new(name: 'Maceio', code: '', city: 'Maceió',
                                  area: 75_000, address: 'Rua Macelino Campos, 196',
                                  cep: '05867-286', description: 'Um galpão ae')
        
        expect(warehouse).not_to be_valid

      end

      it 'false quando campo -cidade- está vazio' do
        warehouse = Warehouse.new(name: 'Maceio', code: 'MCZ', city: '',
                                  area: 75_000, address: 'Rua Macelino Campos, 196',
                                  cep: '05867-286', description: 'Um galpão ae')
        
        expect(warehouse).not_to be_valid

      end

      it 'false quando campo -endereço- está vazio' do
        warehouse = Warehouse.new(name: 'Maceio', code: 'MCZ', city: 'Maceió',
                                  area: 75_000, address: '',
                                  cep: '05867-286', description: 'Um galpão ae')
        
        expect(warehouse).not_to be_valid

      end
    end

    it 'false quando código já está em uso' do
      Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceió',
                       area: 75_000, address: 'Rua Macelino Campos, 196',
                       cep: '05867-286', description: 'Um galpão ae')

      warehouse = Warehouse.new(name: 'Rio', code: 'MCZ', city: 'Rio de Janeiro',
                                area: 80_000, address: 'Av do Aeroporto, 588',
                                cep: '56466-001', description: 'Outro galpão')

      expect(warehouse).not_to be_valid
    end
  end
end
