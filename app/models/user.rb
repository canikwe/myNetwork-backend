class User < ApplicationRecord
  validates :email, uniqueness: true,
    unless: Proc.new { |a| a.email.nil? }
  validates :username, uniqueness: true,
    unless: Proc.new { |a| a.username.nil? }

  has_many :contacts, foreign_key: :requestor_id, class_name: "Contact", dependent: :destroy
  has_many :requested_contact, foreign_key: :requested_id, class_name: "Contact" , dependent: :destroy
  has_many :reminders, through: :contacts
  
  has_secure_password

  accepts_nested_attributes_for :contacts, allow_destroy: true
  
  def name
    "#{self.first_name} #{self.last_name}"
  end

end
