class ItemsController < ApplicationController

  before_filter :authorize

  def index
    # binding.pry
    @items = current_user.items
  end

  def new
    
  end

  def create
    # binding.pry
    # item = Item.new(item_params)
    current_user.items.build(item_params)
    if current_user.save
      redirect_to user_item_path(current_user, current_user.items.last)
      flash[:notice] = "Item created!"
    else
      render 'items/new'
    end
  end

  def show
    @item = Item.find_by(:id => params[:id])
    @category = @item.categories.first
  end

  def destroy
    @item.product = nil
    @item.save
  end

  private

    def item_params
      params.require(:item).permit(:name,:price,:description,:condition,:product, :delete_product)
    end

end
