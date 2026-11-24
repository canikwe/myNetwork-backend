require 'rails_helper'

# Characterization specs: they record how POST /api/v1/login behaves today,
# including known defects (tagged legacy_defect). See spec/README.md.
RSpec.describe 'POST /api/v1/login', type: :request do
  let(:route) { '/api/v1/login' }
  let(:password) { 'correct-horse-42' }
  let!(:user) { create(:user, password: password) }

  def login(params)
    post route, params: params, as: :json
  end

  def json
    JSON.parse(response.body)
  end

  context 'RULE-021: valid username and password' do
    before { login(user: { username: user.username, password: password }) }

    it 'responds 202 with the user, their data and a token' do
      expect(response).to have_http_status(:accepted)
      expect(json.keys).to contain_exactly('message', 'user', 'reminders', 'contacts', 'token', 'authenticated')
      expect(json['message']).to eq('Authenticated! You are lgged in')
      expect(json['authenticated']).to be(true)
      expect(json['user']['id']).to eq(user.id)
      expect(json['reminders']).to eq([])
      expect(json['contacts']).to eq([])
      expect(json['token']).to be_a(String).and be_present
    end

    it 'returns a token that GET /api/v1/profile accepts' do
      get '/api/v1/profile', headers: { 'Authorization' => "Bearer #{json['token']}" }

      expect(response).to have_http_status(:accepted)
      expect(JSON.parse(response.body)['user']['id']).to eq(user.id)
    end
  end

  context 'RULE-021: wrong password' do
    it 'responds 406 and does not authenticate' do
      login(user: { username: user.username, password: 'wrong-password' })

      expect(response).to have_http_status(:not_acceptable)
      expect(json).to eq('message' => 'Username and password do not match', 'authenticated' => false)
    end
  end

  context 'RULE-021: unknown username' do
    it 'responds 406 with the same message as a wrong password' do
      login(user: { username: 'nobody-by-this-name', password: password })

      expect(response).to have_http_status(:not_acceptable)
      expect(json).to eq('message' => 'Username and password do not match', 'authenticated' => false)
    end
  end

  context 'RULE-021: null username' do
    let!(:user_without_username) { create(:user, username: nil, password: password) }

    it 'logs in as the user whose username is NULL', :legacy_defect do
      login(user: { username: nil, password: password })

      expect(response).to have_http_status(:accepted)
      expect(json['user']['id']).to eq(user_without_username.id)
    end
  end
end
