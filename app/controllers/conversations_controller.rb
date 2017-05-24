class ConversationsController < ApplicationController
  def show
    binding.pry
    if Conversation.find_by(name: params[:name])
      @conversation = Conversation.find_by(name: "users-#{current_user.id}-#{params[:property][:owner_id]}")
      @message = Message.new
      @messages = Message.all
    else
      Conversation.new(name)
    end
  end
  
  def index
    #code
  end
end