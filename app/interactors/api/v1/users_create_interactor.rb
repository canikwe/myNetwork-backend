require 'dry/monads'

class Api::V1::UsersCreateInteractor
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)
  include Api::V1::Authenticatable

  def initialize(params:)
    @params = params
  end

  def call
    try_catch do
      save_user
      yield create_token
      yield serialize_success_response
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
  
  def serialize_success_response
    response = { user: serialize_user, token: token, authenticated: true , **base_response_args }
    Success(response)
  end

  def serialize_user
    UserSerializer.new(user)
  end

  def base_response_args
    { reminders: [], contacts: [] }
  end

  def try_catch
    yield
  rescue ActiveRecord::RecordInvalid => e
    serialize_failure_response(e)
  end

  def serialize_failure_response(error)
    response = { user: nil, message: error.message, error: error, authenticated: false, **base_response_args }
    Failure(response)
  end
end