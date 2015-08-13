class MessagesController < ApplicationController
  def index
    @conversation = Conversation.find(params[:conversation_id])
    @messages = @conversation.messages
  end

  def create
    @message = Message.new(message_params)

    @message.save
    redirect_to conversation_messages_path
  end

private
  def message_params
    params.require(:message).permit(:conversation_id, :recipient_id, :sender_id, :content)
  end

end
