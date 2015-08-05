class ItemsController < ApplicationController

  before_filter :authorize

  def index
    # binding.pry
    @items = current_user.items
  end

  def new
    
  end

  def edit
    @item = Item.find_by(:id => params[:id])
  end

  def update
    @current_user = current_user
    @item = Item.find_by(:id => params[:id])
    if @item.update_attributes(item_params)
      flash[:notice] = "Item successfully updated"
      redirect_to user_item_path(@current_user, @item)
    else 
      flash[:notice]  = "Please update again"
      redirect_to edit_user_item_path(@current_user, @item)
    end
  end

  def create
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
    @selleritems = Item.findselleritems(@item)
    
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
