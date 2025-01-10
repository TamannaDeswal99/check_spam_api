class Contact < ApplicationRecord
  belongs_to :user
  validates :name, presence: true 
  validates :phone_number, presence: true
end
