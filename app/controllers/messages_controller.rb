class MessagesController < ApplicationController
  def index
    @message = Message.all

  end

  def create
    binding.pry
    #Conversation.new, if conversation contains buyer and user, then shovel in it.
    @item = Item.find(params[:message][:item_id])
    @message = Message.new(message_params)
    if @message.save
      binding.pry
      @conversation = Conversation.new
      redirect_to messages_path
    else
      flash[:notice] = 'Send message again'
      redirect_to new_message_path(@item)
    end
  end

  def new
# <<<<<<< HEAD
#   @user = User.find(params[:user])  #user the person wishes to contact
#   if params[:item] != ""
#     @item_name = Item.find(params[:item]).name  #item the person wishes to inquire about
#   else 
#     @item_name = ""
#   end 
#   @message = current_user.messages.new
#     # display form
# =======
    #binding.pry
    #@user = User.find(params[:seller_id])
    @item = Item.find(params[:item_id])
   # @conversation = Conversation.find(params[:conversation_id])
# >>>>>>> master
  end

private
  def message_params
    params.require(:message).permit(:sender_id, :recipient_id, :content)
  end

end
