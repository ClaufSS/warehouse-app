# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


Supplier.create!(
  corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
  registration_number: '12345678000101', full_address: 'Rua Principal, 123',
  city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
)

Supplier.create!(
  corporate_name: 'ByteWise Tecnologia Ltda', brand_name: 'ByteWise',
  registration_number: '23456789000102', full_address: 'Av. do Progresso, 456',
  city: 'Belo Horizonte', state: 'MG', email: 'contato@bytewise.com.br'
)

Supplier.create!(
  corporate_name: 'Alimentos Saudáveis Ltda', brand_name: 'AlimSaudáveis',
  registration_number: '34567890000103', full_address: 'Rua das Flores, 789',
  city: 'Florianópolis', state: 'SC', email: 'contato@alimentossa.com.br'
)
Supplier.create!(
  corporate_name: 'Sabores Deliciosos SA', brand_name: 'SaboresDeliciosos',
  registration_number: '45678901000104', full_address: 'Av. da Praia, 987',
  city: 'Rio de Janeiro', state: 'RJ', email: 'contato@saboresdeliciosos.com.br'
)
