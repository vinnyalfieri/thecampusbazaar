class Item < ActiveRecord::Base
  belongs_to :seller, :class_name => 'User'
  delegate :community, to: :seller
end
