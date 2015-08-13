class ConversationsController < ApplicationController

  def index
    @users = User.all 
    @conversations = Conversation.all
  end

  def create
  end

  def new 
    #binding.pry
    @item = Item.find(params[:item_id])
  end

private
  def conversation_params
    params.permit(:seller_id, :buyer_id, :item)
  end

end
