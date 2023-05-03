require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  let (:supplier) { Supplier.create!(
    corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec', registration_number: '12345678000101',
    full_address: 'Rua Principal, 123', city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
  )}

  describe '#valid?' do
    context 'false quando campo' do
      it 'nome estiver vazio' do
        product_model = ProductModel.new(
          name: '', weight: 3500, width: 60,
          height: 35, depth: 8, sku: 'ST-01ML24P0000000001', supplier: supplier
        )

        expect(product_model.valid?).to be_falsey
      end
      
      it 'peso estiver vazio' do
        product_model = ProductModel.new(
          name: 'Monitor LED 24 polegadas', weight: nil, width: 60,
          height: 35, depth: 8, sku: 'ST-01ML24P0000000001', supplier: supplier
        )

        expect(product_model.valid?).to be_falsey
      end
      
      it 'largura estiver vazio' do
        product_model = ProductModel.new(
          name: 'Monitor LED 24 polegadas', weight: 3500, width: nil,
          height: 35, depth: 8, sku: 'ST-01ML24P0000000001', supplier: supplier
        )

        expect(product_model.valid?).to be_falsey
      end
      
      it 'altura estiver vazio' do
        product_model = ProductModel.new(
          name: 'Monitor LED 24 polegadas', weight: 3500, width: 60,
          height: nil, depth: 8, sku: 'ST-01ML24P0000000001', supplier: supplier
        )

        expect(product_model.valid?).to be_falsey
      end
      
      it 'profundidade estiver vazio' do
        product_model = ProductModel.new(
          name: 'Monitor LED 24 polegadas', weight: 3500, width: 60,
          height: 35, depth: nil, sku: 'ST-01ML24P0000000001', supplier: supplier
        )

        expect(product_model.valid?).to be_falsey
      end
      
      it 'sku estiver vazio' do
        product_model = ProductModel.new(
          name: 'Monitor LED 24 polegadas', weight: 3500, width: 60,
          height: 35, depth: 8, sku: '', supplier: supplier
        )

        expect(product_model.valid?).to be_falsey
      end
      
      it 'fornecedor estiver vazio' do
        product_model = ProductModel.new(
          name: 'Monitor LED 24 polegadas', weight: 3500, width: 60,
          height: 35, depth: 8, sku: 'ST-01ML24P0000000001', supplier: nil
        )

        expect(product_model.valid?).to be_falsey
      end
    end


    context 'false quando já está em uso' do
      it 'o código sku' do
        ProductModel.create!(
          name: 'Monitor LED 24 polegadas', weight: 3500, width: 60,
          height: 35, depth: 8, sku: 'ST-01ML24P0000000001', supplier: supplier
        )

        product_model = ProductModel.new(
          name: 'Impressora Multifuncional', weight: 8500, width: 45,
          height: 25, depth: 35, sku: 'ST-01ML24P0000000001', supplier: supplier
        )

        expect(product_model.valid?).to be_falsey
      end
    end

    context 'propriedade' do
      it 'peso deve ser maior que 0' do
        product_model = ProductModel.new(
          name: 'Monitor LED 24 polegadas', weight: 0, width: 60,
          height: 35, depth: 8, sku: 'ST-01ML24P0000000001', supplier: supplier
        )

        expect(product_model.valid?).to be_falsey
      end

      it 'largura deve ser maior que 0' do
        product_model = ProductModel.new(
          name: 'Monitor LED 24 polegadas', weight: 3500, width: 0,
          height: 35, depth: 8, sku: 'ST-01ML24P0000000001', supplier: supplier
        )

        expect(product_model.valid?).to be_falsey
      end

      it 'altura deve ser maior que 0' do
        product_model = ProductModel.new(
          name: 'Monitor LED 24 polegadas', weight: 3500, width: 60,
          height: 0, depth: 8, sku: 'ST-01ML24P0000000001', supplier: supplier
        )

        expect(product_model.valid?).to be_falsey
      end

      it 'profundidade deve ser maior que 0' do
        product_model = ProductModel.new(
          name: 'Monitor LED 24 polegadas', weight: 3500, width: 60,
          height: 35, depth: 0, sku: 'ST-01ML24P0000000001', supplier: supplier
        )

        expect(product_model.valid?).to be_falsey
      end
    end

    it 'false quando sku não tiver 20 caracteres' do
      product_model = ProductModel.new(
        name: 'Monitor LED 24 polegadas', weight: 3500, width: 60,
        height: 35, depth: 8, sku: 'ST-01ML24P0000001', supplier: supplier
      )

      expect(product_model.valid?).to be_falsey
    end
  end
end
