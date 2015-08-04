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

  def create
    @community = Community.new(community_params)
    @community.save
    ###Set the current users community to the community

    redirect_to root_path
  end 

  def search 
  end 

  private
  def community_params
    params.require(:community).permit(:name)
  end
end
