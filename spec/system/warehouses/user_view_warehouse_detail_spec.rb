require 'rails_helper'

describe 'Usuário entra em detalhes de um galpão' do
  it 'e vê informações adicionais' do
    Warehouse.create!(
      name: 'Aeroporto Guarulhos', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida Aeroporto, 1000', cep: '00045-779',
      description: 'Galpão destinado para cargas internacionais'
    )

    visit root_path

    click_on 'Aeroporto Guarulhos'

    expect(page).to have_content 'Galpão GRU'
    expect(page).to have_content 'Nome: Aeroporto Guarulhos'
    expect(page).to have_content 'Cidade: Guarulhos'
    expect(page).to have_content 'Área: 100.000 m2'
    expect(page).to have_content 'Endereço: Avenida Aeroporto, 1000'
    expect(page).to have_content 'CEP: 00045-779'
    expect(page).to have_content 'Galpão destinado para cargas internacionais'
  end

  it 'e volta para tela inicial' do
    Warehouse.create!(
      name: 'Aeroporto Guarulhos', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida Aeroporto, 1000', cep: '00045-779',
      description: 'Galpão destinado para cargas internacionais'
    )

    visit root_path

    click_on 'Aeroporto Guarulhos'

    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end
