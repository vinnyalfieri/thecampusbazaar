class MessagesController < ApplicationController
  def index
    @conversations = current_user.mailbox.conversations
    @notifications = current_user.mailbox.notifications.group_by &:sender_id
    @receipts = current_user.mailbox.receipts
    @message = current_user.mailbox.inbox.first.messages.first.body

  end

# GET /message/new
  def new
  @user = User.find(params[:user])  #user the person wishes to contact
  if params[:item] != ""
    @item_name = Item.find(params[:item]).name  #item the person wishes to inquire about
  else 
    @item_name = ""
  end 
  @message = current_user.messages.new
    # display form
  end

  # POST /message/create
  def create
    @recipient = User.find(params[:user])
    current_user.send_message(@recipient, params[:body], params[:subject])
    flash[:notice] = "Message has been sent!"
    redirect_to :conversations
  end
end