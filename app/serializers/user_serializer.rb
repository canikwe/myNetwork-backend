class UserSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :contacts
  # has_many :alerts, through: :requests

  # def friends
  #   friends = {}
  #   self.object.requests.each do |r|
  #     friends[r.requested.name] = r.alerts
  #   end
  #   friends
  # end

end
