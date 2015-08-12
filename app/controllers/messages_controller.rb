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
  @item = Item.find(params[:item])  #itme the person wishes to inquire about
  @message = current_user.messages.new
    # display form
  end

  # POST /message/create
  def create
    @recipient = User.find(params[:user])
    current_user.send_message(@recipient, params[:body], params[:subject])
    sleep(10)
    flash[:notice] = "Message has been sent!"
    redirect_to root_path
  end
end