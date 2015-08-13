class ConversationController < ApplicationController

  def index
    @users = User.all 
    @conversations = Conversation.all
  end

  def create
  end

private
  def conversation_params
    params.permit(:seller_id, :buyer_id)
  end

end
