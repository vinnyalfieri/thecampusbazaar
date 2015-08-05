# class MessagesController < ApplicationController

#   # GET /message/new
#   def new
#     @user = current_user
#     @message = current_user.messages.new
#   end

#    # POST /message/create
#    def create
#     @recipient = current_user
#     current_user.send_message(@recipient, params[:body], params[:subject])
#     flash[:notice] = 'Message has been sent!'
#     redirect_to :conversations
#   end
# end


class MessagesController < ApplicationController
  def index
    @conversations = current_user.mailbox.conversations
    @notifications = current_user.mailbox.notifications.group_by &:sender_id
    @receipts = current_user.mailbox.receipts
    @message = current_user.mailbox.inbox.first.messages.first.body

  end

# GET /message/new
  def new
  @user = User.find(params[:user])
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