class User < ApplicationRecord
  validates :email, uniqueness: true,
    unless: Proc.new { |a| a.email.nil? }
  validates :username, uniqueness: true,
    unless: Proc.new { |a| a.username.nil? }

  has_many :contacts, dependent: :destroy
  has_many :reminders, through: :contacts

  has_one_attached :photo

  has_secure_password

  accepts_nested_attributes_for :contacts, allow_destroy: true #refactor this later

  def name
    "#{self.first_name} #{self.last_name}"
  end


end
