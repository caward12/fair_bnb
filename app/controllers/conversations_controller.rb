class ConversationsController < ApplicationController
  def create
    if @conversation = Conversation.find_by(name: "users-#{params[:user_1_id]}-#{params[:user_2_id]}")
      redirect_to conversation_path(@conversation, user_1_id: params[:user_1_id], user_2_id: params[:user_2_id])
    else
      @conversation = Conversation.create(name: "users-#{params[:user_1_id]}-#{params[:user_2_id]}")
      redirect_to conversation_path(@conversation, user_1_id: params[:user_1_id], user_2_id: params[:user_2_id])
    end
  end
  
  def show
    @conversation = Conversation.find_by(name: "users-#{params[:user_1_id]}-#{params[:user_2_id]}")
    @user_1_first_name = User.find(params[:user_1_id]).first_name
    @user_2_first_name = User.find(params[:user_2_id]).first_name
    @message = Message.new
    @messages = Message.all
  end
  
  def index
    @conversations = Conversation.find_by_user(current_user.id)
  end
end