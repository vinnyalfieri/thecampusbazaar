class Item < ActiveRecord::Base
  belongs_to :seller, :class_name => 'User'
  delegate :community, to: :seller
  has_many :item_categories
  has_many :categories, through: :item_categories

  validates :name, presence: true


  def self.findselleritems(item)
    user = User.find_by(:id => item.seller.id)
    user.items
  end
end
