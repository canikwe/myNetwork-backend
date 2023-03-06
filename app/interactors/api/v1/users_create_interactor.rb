class Api::V1::UsersCreateInteractor
  include Api::V1::Authenticatable

  def initialize(params:)
    @params = params
  end

  def call
    save_user
    create_token
    serialize_user_response
  end

  private

  attr_accessor :params, :user, :token

  def save_user
    self.user = User.create!(params)
  end

  def create_token
    self.token = encode({ user_id: user.id })
  end
  
  def serialize_user_response
    {
      user: serialize_user,
      reminders: [],
      contacts: [],
      token: token,
      authenticated: true
    }
  end

  def serialize_user
    UserSerializer.new(user)
  end
end