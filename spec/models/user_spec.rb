require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context '#valid?' do
    it 'se email estiver no padrão' do
      user = User.new(name: 'Marcel', email: 'email.incompleto', password: 'f4k3p455w0rd')

      expect(user.valid?).to be_falsy
    end

    it 'senha tem mais de 8 ou mais caracteres' do
      user = User.new(name: 'Marcel', email: 'marcel@gmail.com', password: 'f4k3p45')

      expect(user.valid?).to be_falsy
    end

    it 'se email não está em uso' do
      User.create!(name: 'Marcel', email: 'marcel@gmail.com', password: 'f4k3p455w0rd')

      user = User.new(name: 'Marcelino', email: 'marcel@gmail.com', password: '07h3rp455w0rd')

      expect(user.valid?).to be_falsy
    end
  end
end
