class ItemsController < ApplicationController
  before_filter :authorize

  def index

   
  end

  def show
        @item = Item.find_by(:id => params[:id])
  end

private


end
