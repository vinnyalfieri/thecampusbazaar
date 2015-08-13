class MessagesController < ApplicationController
  def index
    @conversation = Conversation.find(params[:conversation_id])
    @messages = @conversation.messages
  end

  def create
    @message = Message.new(message_params)
    @message.save
    redirect_to conversation_messages_path
    #Conversation.new, if conversation contains buyer and user, then shovel in it.
    # @item = Item.find(params[:message][:item_id])
    # @message = Message.new(message_params)
    # if @message.save
    #   binding.pry
    #   @conversation = Conversation.new
    #   redirect_to messages_path
    # else
    #   flash[:notice] = 'Send message again'
    #   redirect_to new_message_path(@item)
    # end
  end

  def new
    #binding.pry
    #@user = User.find(params[:seller_id])
    @item = Item.find(params[:item_id])
   # @conversation = Conversation.find(params[:conversation_id])
  end

private
  def message_params
    params.require(:message).permit(:conversation_id, :recipient_id, :sender_id, :content)
  end

end
