class User < ApplicationRecord
  has_many :gossips
  belongs_to :city, optional: true
  has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
  has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessage"
  has_many :comments
  #has_many :gossips, through: :comments
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :likes, dependent: :destroy
end
