require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe 'GET #index' do
    let!(:users) { create_list(:user, 3) }

    it 'returns http success' do
      get :index

      expect(response).to have_http_status(:success)
    end

    it 'returns users' do
      get :index

      expect(JSON.parse(response.body)['users'].size).to eq(3)
    end

    it 'validates root key is users' do
      get :index

      expect(JSON.parse(response.body).keys).to eq(['users'])
    end

    context 'when email param is present' do
      it 'returns user' do
        get :index, params: { email: users.first.email }

        expect(JSON.parse(response.body)['users'].first['email']).to eq(users.first.email)
      end
    end

    context 'when query params are not valid' do
      it 'returns unprocessable entity status' do
        get :index, params: { cellphone: 'invalid' }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST #create' do
    before do
      WebMock.stub_request(:post, 'https://w7nbdj3b3nsy3uycjqd7bmuplq0yejgw.lambda-url.us-east-2.on.aws/v1/account').
        to_return(status: 200, body: { account_key: '123' }.to_json)
    end

    context 'when attributes are valid' do
      let(:attributes) do
        {
          email: email,
          phone_number: '+12312312',
          full_name: SecureRandom.hex,
          password: 'password',
          password_confirmation: 'password',
          key: SecureRandom.hex
        }
      end

      let(:email) { "#{SecureRandom.hex}@firstleaft.com" }

      it 'creates an user' do
        expect { post :create, params: attributes }.to change(User, :count).by(1)
      end

      it 'returns created status' do
        post :create, params: attributes

        expect(response).to have_http_status(:created)
      end

      it 'returns user' do
        post :create, params: attributes

        expect(JSON.parse(response.body).keys).to eq(%w[email phone_number full_name key account_key metadata])
      end

      it 'creates user with a random key' do
        post :create, params: attributes

        expect(User.last.key).not_to be_nil
      end

      it 'creates user with a hashed password' do
        post :create, params: attributes

        expect(User.last.password).not_to eq(attributes[:password])
      end

      it 'creates user with an account key' do
        Sidekiq::Testing.inline! do
          post :create, params: attributes

          expect(User.last.account_key).to eq('123')
        end
      end

      context 'when attributes are invalid' do
        let(:email) { nil }

        it 'does not create an user' do
          expect { post :create, params: attributes }.not_to change(User, :count)
        end

        it 'returns unprocessable entity status' do
          post :create, params: attributes

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns errors' do
          post :create, params: attributes

          expect(JSON.parse(response.body).keys).to eq(['errors'])
        end
      end
    end
  end
end