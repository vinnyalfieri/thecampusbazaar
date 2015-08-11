class CommunitiesController < ApplicationController
  skip_before_action :authorize, only: :show
  before_action :check_community, only: [:search, :create, :new]
  #Index => List all different schools
  def info
    @user = User.find(session[:user_id]) 
    @community = Community.find(@user.community_id)
  end 

  def search

  end 

  def set 
    @user = User.find(session[:user_id])
    @community = Community.find(params["/community"][:community_id])
    @user.community = @community
    @user.save
    redirect_to root_path
  end 

  #Show => Show community & all items
  def show
    if !current_user
      render 'static_pages/home'
    else
      @community = current_user.community
      #get all items for sale in a community
      @items = @community.items.reject{|item| current_user.items.include?(item)}.select{|item| item.status == 'available'}
      @categories = @community.categories.distinct
    end
    
    if params[:category_id]
      case params[:category_id]
      when "all"
        @items = @community.items.reject{|item| current_user.items.include?(item)}.select{|item| item.status == 'available'}
      else
        @items = Item.get_items_of_specific_category(@items, params[:category_id])
      end
    end
  end

  def create
    @community = Community.new(community_params)
    @community.save
    @user = User.find(session[:user_id])
    @user.community = @community
    @user.save
    redirect_to root_path
  end 

  private
  def community_params
    params.require(:community).permit(:name)
  end

  def check_community 
    unless current_user.community == nil
      flash[:error] = "You already have a community!"
      redirect_to root_path # halts request cycle
    end
  end 
end
