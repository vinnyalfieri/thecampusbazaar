class Item < ActiveRecord::Base
  attr_accessor :delete_product, :delete_avatar

  belongs_to :seller, :class_name => 'User'
  delegate :community, to: :seller
  has_many :item_categories
  has_many :categories, through: :item_categories
  has_many :offers
  has_many :conversations

  accepts_nested_attributes_for :categories

  validates :name, presence: true

  before_validation {product.clear if delete_product =='1'}

  has_attached_file :product, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => 'placeholder-product.gif'
  validates_attachment_content_type :product, :content_type => /\Aimage\/.*\Z/

  def self.findselleritems(item)
    user = User.find_by(:id => item.seller.id)
    user.items
  end

  def self.get_items_of_specific_category(items, category_id)
    category = Category.find_by(:id => category_id)
    items.select{ |item| item.categories.include?(category) && item.available? }
  end

  def status
    any_accepted? ? 'sold' : 'available'
  end

  def available?
    self.status == 'available'
  end

  def any_accepted?
    self.offers.any?{|offer| offer.status == 'accepted'}
  end 

  def conversation_exist?(current_user)
    self.conversations.each do |convo|
      if between_seller_and_buyer?(convo, current_user)
        return true 
      end 
    end 
    return false
  end 

  def convo_id(current_user)
    self.conversations.each do |convo|
      if between_seller_and_buyer?(convo, current_user)
        return convo.id
      end 
    end 
  end 

  def prop
    case 
    when self.price < 50.0
      return "p1"
    when self.price < 100.0
      return "p2"
    when self.price < 500.0
      return "p3"
    when self.price < 1000.0
      return "p4"
    else
      return "p5"
    end
  end

  private 
  def between_seller_and_buyer?(convo, current_user)
    (convo.user1 == current_user && convo.user2 == self.seller) || (convo.user2 == current_user && convo.user1 == self.seller)
  end 




end
