class User < ApplicationRecord
  # Validations
  validates :email, uniqueness: true,
    unless: Proc.new { |a| a.email.nil? }
  validates :username, uniqueness: true,
    unless: Proc.new { |a| a.username.nil? }

# Associations
  has_many :contacts, dependent: :destroy
  has_many :reminders, through: :contacts
  has_one_attached :photo

# Authentication
  has_secure_password

# Custom Methods
  def name
    "#{self.first_name} #{self.last_name}"
  end

end
