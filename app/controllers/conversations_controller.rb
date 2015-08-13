class ConversationsController < ApplicationController

  def index
    @users = User.all 
    @conversations = Conversation.all
  end

  def create
    @conversation = Conversation.new(conversation_params)
    @conversation.save
    @message = Message.new
    @message.conversation_id = @conversation.id
    @message.recipient_id = @conversation.user2_id
    @message.sender_id = @conversation.user1_id
    @message.content = params[:conversation][:messages][:content]
    @message.save
    redirect_to conversations_path
  end

  def new 
    #binding.pry
    @item = Item.find(params[:item_id])
  end

private
  def conversation_params
    params.require(:conversation).permit(:user1_id, :user2_id, :item_id, :content)
  end

end
