require 'rails_helper'

describe 'Usário edita um galpão' do
  before :each do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    login_as(user, :scope => :user)
  end

  
  it 'a partir da página de detalhes' do
    Warehouse.create!(
      name: 'Aeroporto Guarulhos', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida Aeroporto, 1000', cep: '00045-779',
      description: 'Galpão destinado para cargas internacionais'
    )

    visit root_path
    click_on 'Aeroporto Guarulhos'
    click_on 'Editar'

    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field 'Nome', with: 'Aeroporto Guarulhos'
    expect(page).to have_field 'Código', with: 'GRU'
    expect(page).to have_field 'Área', with: '100000'
    expect(page).to have_field 'Endereço', with: 'Avenida Aeroporto, 1000'
    expect(page).to have_field 'CEP', with: '00045-779'
    expect(page).to have_field 'Descrição', with: 'Galpão destinado para cargas internacionais'
    expect(page).to have_field 'Cidade', with: 'Guarulhos'
  end
  
  it 'com sucesso' do
    Warehouse.create!(
      name: 'Aeroporto Guarulhos', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida Aeroporto, 1000', cep: '00045-779',
      description: 'Galpão destinado para cargas internacionais'
    )

    visit root_path
    click_on 'Aeroporto Guarulhos'
    click_on 'Editar'

    fill_in 'Nome', with: 'Galpão internacional'
    fill_in 'Área', with: '120000'
    fill_in 'Endereço', with: 'Avenida Aeroporto, 1001'

    click_on 'Enviar'

    expect(page).to have_content 'Galpão atualizado com sucesso.'
    expect(page).to have_content 'Nome: Galpão internacional'
    expect(page).to have_content 'Área: 120.000 m2'
    expect(page).to have_content 'Endereço: Avenida Aeroporto, 1001'

  end

  it 'com informações incorretas' do
    Warehouse.create!(
      name: 'Aeroporto Guarulhos', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida Aeroporto, 1000', cep: '00045-779',
      description: 'Galpão destinado para cargas internacionais'
    )

    visit root_path
    click_on 'Aeroporto Guarulhos'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Área', with: ''

    click_on 'Enviar'

    expect(page).to have_content('Não foi possível atualizar o galpão.')
  end
end
