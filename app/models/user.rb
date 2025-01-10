class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contacts, dependent: :destroy
  validates :phone_number, presence: true, uniqueness: true
  validates :name, presence: true

  def in_contact_list?(contact)
    contacts.exists?(phone_number: contact.phone_number)
  end
end
