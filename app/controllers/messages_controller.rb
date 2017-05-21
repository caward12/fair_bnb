class MessagesController < ApplicationController
  
  def index
    @messages = Message.all
    @message = Message.new
  end
  
  def create
    message = Message.new(message_params)
    message.user = current_user
    if message.save
      ActionCable.server.broadcast 'messages',
        message: message.body,
        user: message.user.first_name
      head :ok
    end
  end

  private

    def message_params
      params.require(:message).permit(:body)
    end
end