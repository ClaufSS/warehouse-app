require 'rails_helper'

describe 'Usuário cadastra pedido' do
  it 'apenas se estiver autenticado' do
    visit root_path

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    user = User.create!(:name => 'Jorginho', :email => 'jorginho@example.com', :password => 'f4k3p455w0rd')
    login_as(user, :scope => :user)

    warehouse = Warehouse.create!(
      name: 'Aeroporto Guarulhos', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida Aeroporto, 1000', cep: '00045-779',
      description: 'Galpão destinado para cargas internacionais'
    )

    supplier = Supplier.create!(
      corporate_name: 'Soluções Tecnológicas SA', brand_name: 'SolTec',
      registration_number: '12345678000101', full_address: 'Rua Principal, 123',
      city: 'São Paulo', state: 'SP', email: 'contato@solutecltda.com.br'
    )


    visit root_path

    within 'nav' do
      click_on 'Registrar pedido'
    end

    within "form[action='/orders']" do
      select 'GRU - Aeroporto Guarulhos', from: 'Galpão'
      select 'Soluções Tecnológicas SA - SolTec', from: 'Fornecedor'
      fill_in 'Data prevista de entrega',	with: 1.day.from_now
      click_on 'Salvar'
    end

    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'Galpão de destino: GRU - Aeroporto Guarulhos'
    expect(page).to have_content 'Fornecedor: Soluções Tecnológicas SA - SolTec'
    expect(page).to have_content 'Usuário do pedido: Jorginho'
    expect(page).to have_content "Data prevista de entrega: #{I18n.localize 1.day.from_now.to_date}"
  end
end
