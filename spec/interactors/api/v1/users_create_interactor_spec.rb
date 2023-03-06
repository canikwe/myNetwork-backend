require 'rails_helper'

RSpec.describe 'Api::V1::UsersCreateInteractor' do
  let(:user) { build(:user) }
  let(:params) do
    {
      first_name: user.first_name,
      last_name: user.last_name,
      username: user.username,
      email: user.email,
      bio: user.bio,
      password: user.password,
    }
  end
  let(:subject) { Api::V1::UsersCreateInteractor.new(params: params) }
  let(:result) { subject.call }

  describe 'Initialization' do
    it 'can instantiate' do
      expect(subject).to be_instance_of(Api::V1::UsersCreateInteractor)
    end
  end

  describe '#call' do
    context 'when the user is saved' do
      before do
        # Stub out Active Record's save method
        allow(subject).to receive(:save_user).and_return(true)
        allow(subject).to receive(:user).and_return(user)
      end
  
      it 'returns a user' do
        saved_user = result[:user].object
        expect(saved_user).to be_instance_of(User)
      end
  
      it "returns the user's signin token" do
        expect(result[:token]).to be_instance_of(String)
      end
  
      it 'returns the user as authenticated' do
        expect(result[:authenticated]).to be_truthy
      end
  
      it "returns the user's reminders" do
        user_reminders = result[:reminders]
        expect(user_reminders).to be_instance_of(Array)
        expect(user_reminders).to be_empty
      end
  
      it "returns the user's contacts" do
        user_contacts = result[:contacts]
        expect(user_contacts).to be_instance_of(Array)
        expect(user_contacts).to be_empty
      end
    end

    context 'when the user is not saved' do
      before do
        allow(subject).to receive(:save_user).and_raise(ActiveRecord::RecordInvalid)
        # allow(subject).to receive(:user).and_return(user)
      end

      it 'returns an error' do
        expect(result[:errors]).to be_instance_of(Array)
        expect(result[:errors]).to_not be_empty
      end

      it 'returns the user as not authenticated' do
        expect(result[:authenticated]).to be_falsey
      end
    end
  end
end