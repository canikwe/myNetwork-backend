require 'dry/monads'
# require 'dry/monads/result'
# require 'dry/monads/do'

class Api::V1::UsersCreateInteractor
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)
  include Api::V1::Authenticatable

  def initialize(params:)
    @params = params
  end

  def call
    my_rescue do
       save_user
      yield create_token
      yield serialize_user_response
    end
  end

  private

  attr_accessor :params, :user, :token

  def save_user
    self.user = User.create!(params)
    Success()
  end

  def create_token
    self.token = encode({ user_id: user.id })
    Success()
  end
  
  def serialize_user_response
    response = {
      user: serialize_user,
      reminders: [],
      contacts: [],
      token: token,
      authenticated: true
    }
    Success(response)
  end

  def serialize_user
    UserSerializer.new(user)
  end

  def my_rescue
    yield
  rescue ActiveRecord::RecordInvalid => e
    Failure({
      authenticated: false,
      message: e.message,
      error: e
    })
  end
end