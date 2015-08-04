class CommunitiesController < ApplicationController
  before_filter :authorize

  #Index => List all different schools


  def search

  end 

  #Show => Show community & all items
  def show
    if !current_user
      render 'static_pages/home'
    end

    @community = current_user.community
    #get all items for sale in a community
    @items = @community.items.reject{|item| current_user.items.include?(item)}
  end



  def create
    @community = Community.new(community_params)
    @community.save
    @user = User.find(session[:user_id])
    @user.community = @community
    @user.save
    binding.pry
    redirect_to root_path
  end 

  private
  def community_params
    params.require(:community).permit(:name)
  end
end
