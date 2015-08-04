class CommunitiesController < ApplicationController
  before_filter :authorize

  #Index => List all different schools



  #Show => Show community & all items
  def show
    if !current_user
      render 'static_pages/home'
    end

    @community = current_user.community
    # binding.pry
    #get all items for sale in a community
    @items = @community.items
  end

end
