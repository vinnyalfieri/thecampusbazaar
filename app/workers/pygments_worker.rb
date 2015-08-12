class PygmentsWorker
  include Sidekiq::Worker

  def perform(recipient_id)
    recipient = User.find(recipient_id)
    current_user.send_message(recipient, params[:body], params[:subject])
  end
end