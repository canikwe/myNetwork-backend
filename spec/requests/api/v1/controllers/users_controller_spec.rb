require 'rails_helper'

RSpec.describe 'Api::V1::UsersController', type: :request do
  let(:user) { build(:user) }
  let(:params) do
    { user: 
      {
        first_name: user.first_name,
        last_name: user.last_name,
        username: user.username,
        email: user.email,
        bio: user.bio,
        password: Faker::Internet.password,
      }
    }
  end
  let(:subject) { Api::V1::UsersController.new }

  context 'Initialization' do
    it 'can instantiate' do
      expect(subject).to be_instance_of(Api::V1::UsersController)
    end
  end

  describe '#create' do
    context "when the user's params are valid" do
      before do
        post '/api/v1/users', params: params
      end
  
      it 'is a successful response' do
        expect(response).to be_successful
        expect(response).to have_http_status(:accepted)
      end
    end

    context "when the user's params are invalid" do
      before do
        post '/api/v1/users', params: { user: { first_name: '' } }
      end
  
      it 'is an unsuccessful response' do
        expect(response).to_not be_successful
        expect(response).to have_http_status(:not_acceptable)
      end
    end
  end
end