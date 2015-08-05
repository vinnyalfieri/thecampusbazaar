class MessagesController < ApplicationController

  # GET /message/new
  def new
    @user = current_user
    @message = current_user.messages.new
  end

   # POST /message/create
   def create
    @recipient = current_user
    current_user.send_message(@recipient, params[:body], params[:subject])
    flash[:notice] = 'Message has been sent!'
    redirect_to :conversations
  end
end