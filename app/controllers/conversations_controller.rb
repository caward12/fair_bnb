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
    property = Property.find(params[:property_id])
    pc = PropertyConversation.fetch(property: property, user: current_user)
    convo = ChatterConversation.find(pc.cid)
    @conversation = ConversationPresenter.new(convo: convo, property: property, guest: current_user)
  end

  def index
    if current_user
      @conversations = Conversation.find_by_user(current_user.id)
    else
      redirect_to root_path
      flash[:danger] = "You must be a user to access messaging"
    end
  end
end