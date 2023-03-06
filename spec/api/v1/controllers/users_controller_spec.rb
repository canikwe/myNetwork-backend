require 'rails_helper'

RSpec.describe 'Api::V1::UsersController' do
  let(:user) { build(:user) }
  let(:subject) { Api::V1::UsersController.new }

  context 'Initialization' do
    it 'can instantiate' do
      expect(subject).to be_instance_of(Api::V1::UsersController)
    end
  end
end