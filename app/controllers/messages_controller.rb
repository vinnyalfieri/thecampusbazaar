class MessagesController < ApplicationController

  def index
    @conversation = Conversation.find(params[:conversation_id])
    @recipient = @conversation.recipient(current_user)
    @messages = @conversation.messages
 
    respond_to do |format|
        format.html {}
        format.js {}
      end
  end

  def create
    @message = Message.new(message_params)
    @message.save
    @conversation = Conversation.find(params[:conversation_id])
    @recipient = @conversation.recipient(current_user)
    @messages = @conversation.messages
    respond_to do |format|
        format.html {}
        format.js { }
      end
   
  end

private
  def message_params
    params.require(:message).permit(:conversation_id, :recipient_id, :sender_id, :content)
  end

end
