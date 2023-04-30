require 'rails_helper'

describe 'Usuário visita Home-page' do
  it 'e vê nome da app' do
    visit root_path

    expect(page).to have_content 'Galpões & Estoques'
  end

  it 'e vê galpões cadastrados' do
    Warehouse.create!(name: 'Rio', code: 'RJU', city: 'Rio de Janeiro',
                     area: 80_000, address: 'Av do Aeroporto, 588',
                     cep: '56466-001', description: 'Um galpão ae')

    Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceió',
                     area: 75_000, address: 'Rua Macelino Campos, 196',
                     cep: '05867-286', description: 'Outro galpão')
                     
    Warehouse.create!(name: 'SPaulo', code: 'SPR', city: 'São Paulo',
                     area: 120_000, address: 'Av Paulista, 648',
                     cep: '00010-253', description: 'Mias um galpão')

    visit root_path

    expect(page).not_to have_content 'Não há galpões cadastrados'

    expect(page).to have_content 'Nome: Rio'
    expect(page).to have_content 'Código: RJU'
    expect(page).to have_content 'Cidade: Rio de Janeiro'
    expect(page).to have_content 'Área: 80.000 m2'

    expect(page).to have_content 'Nome: Maceio'
    expect(page).to have_content 'Código: MCZ'
    expect(page).to have_content 'Cidade: Maceió'
    expect(page).to have_content 'Área: 75.000 m2'

    expect(page).to have_content 'Nome: SPaulo'
    expect(page).to have_content 'Código: SPR'
    expect(page).to have_content 'Cidade: São Paulo'
    expect(page).to have_content 'Área: 120.000 m2'
  end

  it 'e vê que não existem galpões cadastrados' do
    visit root_path

    expect(page).to have_content 'Não há galpões cadastrados'
  end
end
