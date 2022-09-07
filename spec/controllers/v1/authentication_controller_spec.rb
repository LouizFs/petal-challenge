require 'rails_helper'

describe V1::AuthenticationController do
  let!(:user) { create(:user, email:"teste@hotmail.com", password: "123456", username: "teste") }
  
  describe "#login" do
    context 'when pass correct credencials' do
      
      let(:valid_attributes) do
        { 
          email: "teste@hotmail.com",
          password: "123456"
        }
      end

      subject { post :login, params: valid_attributes }

      it 'should have 201 status code' do
        subject

        expect(response).to have_http_status(:ok)
      end

      it 'should have proper json body' do
        subject

        expect(json_data["token"]).to be_present
      end
      
    end

    context 'when pass incorrect credencials' do
      
      let(:valid_attributes) do
        { 
          email: "erro@hotmail.com",
          password: "error"
        }
      end

      subject { post :login, params: valid_attributes }

      it 'should have 401 status code' do
        subject

        expect(response).to have_http_status(:unauthorized)
      end

      it 'should have proper json body' do
        subject

        expect(json_data["token"]).to be_blank
      end
      
    end
  end
end
