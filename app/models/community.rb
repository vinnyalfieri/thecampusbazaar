class Community < ActiveRecord::Base
  has_many :sellers, :class_name => 'User'
  has_many :items, through: :sellers
  has_many :categories, through: :items

  validates :name, presence: true
end
