require 'rails_helper'

describe V1::PokemonsController do
  let!(:user) { create(:user, email:"teste@hotmail.com", password: "123456", username: "teste") }
  let(:token) { "Bearer #{::JsonWebToken.encode(user_id: user.id)}" }
 
  before do
    request.headers["Authorization"] = token
    Pokemon.destroy_all
  end

  describe '#index' do
    subject { get :index }
   
    it 'should return success response' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return proper json' do
      create_list :pokemon, 2, name: "teste"
      
      subject

      expect(json_data.first["name"]).to eq("teste")
    end

    it 'should paginate results' do
      create_list :pokemon, 50

      get :index, params: { page: 2 }

      expect(json_data.length).to eq 25
    end

    it 'should filter results' do
      create :pokemon, name: "pikachu"
      create :pokemon, name: "bomba"

      get :index, params: { name: "pikachu" }

      expect(json_data.length).to eq 1
    end

    it_behaves_like 'unauthorized'
  end

  describe '#show' do 
    let(:pokemon) { create :pokemon }

    subject { get :show, params: { id: pokemon.id } }

    it 'should return success response' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return proper json' do
      subject

      expect(json_data["name"]).to eq("teste")
    end

    it_behaves_like 'unauthorized'
  end

  describe '#create' do
    subject { post :create }

    context 'when invalid parameters provided' do
      let(:invalid_attributes) do
        { 
          pokemon: {
            name: nil
          }
        }
      end

      subject { post :create, params: invalid_attributes }

      it 'should return 422 status code' do
        subject

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return proper error json' do
        subject

        expect(json_data['error']).to include(
          "Name can't be blank"
        )
      end
    end
    
    context 'when success request sent' do
      
      let(:valid_attributes) do
        { 
          pokemon: {
            name: "teste"
          }
        }
      end

      subject { post :create, params: valid_attributes }

      it 'should have 201 status code' do
        subject

        expect(response).to have_http_status(:created)
      end

      it 'should have proper json body' do
        subject

        expect(json_data["name"]).to eq("teste")
      end

      it 'should create the pokemon' do
        expect{ subject }.to change{ Pokemon.count }.by(1)
      end
    end

    it_behaves_like 'unauthorized'
  end

  describe '#update' do
    let(:pokemon) { create :pokemon, name: "teste" }
  
    subject { patch :update, params: { id: pokemon.id } }

    context 'when invalid parameters provided' do
      let(:invalid_attributes) do
        {
          pokemon: {
            name: nil
          }
        }
      end

      subject do
        patch :update, params: invalid_attributes.merge(id: pokemon.id)
      end

      it 'should return 422 status code' do
        subject

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return proper error json' do
        subject

        expect(json_data['error']).to include(
          "Name can't be blank"
        )
      end
    end

    context 'when success request sent' do
      
      let(:valid_attributes) do
        {
          pokemon: {
            name: "teste 2"
          }
        }
      end

      subject do
        patch :update, params: valid_attributes.merge(id: pokemon.id)
      end

      it 'should have 200 status code' do
        subject
        
        expect(response).to have_http_status(:ok)
      end


      it 'should update the pokemon' do
        subject

        expect(pokemon.reload.name).to eq(
          'teste 2'
        )
      end
    end

    it_behaves_like 'unauthorized'
  end

  describe '#destroy' do 
    let!(:pokemon) { create :pokemon }
    
    subject { delete :destroy, params: { id: pokemon.id } }

    context 'when success request sent' do

      it 'should have 204 status code' do
        subject

        expect(response).to have_http_status(:no_content)
      end

      it 'should destroy the pokemon' do
        expect{ subject }.to change{ Pokemon.count }.by(-1)
      end
    end

    it_behaves_like 'unauthorized'
  end
end