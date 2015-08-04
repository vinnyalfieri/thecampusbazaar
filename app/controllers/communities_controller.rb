class CommunitiesController < ApplicationController
  before_filter :authorize

  def index
    #get the current users community (id) 
    @community = current_user.community
    # binding.pry
    #get all items for sale in a community
    @items = @community.items

    
    #each item should be a link to that items page show page.

  end


end
