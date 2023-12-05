require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) do
        {
          user: {
            full_name: 'John Doe',
            email: 'john@example.com',
            password: 'password123'
          }
        }
      end

      it 'creates a new user' do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end

      it 'returns a successful response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'returns a success message' do
        post :create, params: valid_params
        response_json = JSON.parse(response.body)
        expect(response_json['message']).to eq('User created successfully')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          user: {
            full_name: 'John Doe',
            email: 'invalid_email',
            password: 'short'
          }
        }
      end

      it 'does not create a new user' do
        expect {
          post :create, params: invalid_params
        }.not_to change(User, :count)
      end

      it 'returns an unprocessable entity response' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error messages' do
        post :create, params: invalid_params
        response_json = JSON.parse(response.body)
        expect(response_json['errors']).to be_present
      end
    end
  end
end
