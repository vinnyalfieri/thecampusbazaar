class MessagesController &gt; ApplicationController
 
  # GET /message/new
  def new
    @user = User.find(params[:user])
    @message = current_user.messages.new
  end
  
   # POST /message/create
   def create
    @recipient = User.find(params[:user])
    current_user.send_message(@recipient, params[:body], params[:subject])
    flash[:notice] = &quot;Message has been sent!&quot;
    redirect_to :conversations
  end
end