class Item < ActiveRecord::Base
  attr_accessor :delete_product

  belongs_to :seller, :class_name => 'User'
  delegate :community, to: :seller
  has_many :item_categories
  has_many :categories, through: :item_categories
  attr_accessor :delete_avatar

  validates :name, presence: true


  before_validation {product.clear if delete_product =='1'}

  has_attached_file :product, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ActionController::Base.helpers.asset_path('placeholder-product.gif')
  validates_attachment_content_type :product, :content_type => /\Aimage\/.*\Z/

  def self.findselleritems(item)
    user = User.find_by(:id => item.seller.id)
    user.items
  end
end
