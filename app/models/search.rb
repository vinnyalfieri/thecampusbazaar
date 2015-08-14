class Search
  def self.for(keyword, user)
    user.community.items.select{|item| item.name.downcase.include?(keyword.downcase)}.reject{ |item| item.seller == user} 
  end
end