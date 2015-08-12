class Search
  def self.for(keyword)
    Item.all.select{|item| item.name.downcase.include?(keyword.downcase)} 
  end
end