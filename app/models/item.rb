class Item < ActiveRecord::Base
  belongs_to :seller, :class_name => 'User'
  delegate :community, to: :seller
  has_many :item_categories
  has_many :categories, through: :item_categories
  attr_accessor :delete_avatar

  validates :name, presence: true

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ActionController::Base.helpers.asset_path('placeholder-avatar.png')
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def self.findselleritems(item)
    user = User.find_by(:id => item.seller.id)
    user.items
  end
end
