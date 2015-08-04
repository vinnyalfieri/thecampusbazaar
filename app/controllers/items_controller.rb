class ItemsController < ApplicationController

  before_filter :authorize

  def new
    
  end

  def create
    # binding.pry
    # item = Item.new(item_params)
    current_user.items.build(item_params)
    if current_user.save
      redirect_to community_user_item_path(current_user.community, current_user, current_user.items.last)
      flash[:notice] = "Item created!"
    else
      render 'items/new'
    end
  end

  def show
    @item = Item.find_by(:id => params[:id])
  end

  private

    def item_params
      params.require(:item).permit(:name,:price,:description,:condition)
    end

end
