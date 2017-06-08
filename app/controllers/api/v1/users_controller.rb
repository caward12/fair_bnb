class Api::V1::UsersController < ApplicationController

  def index
    render json: User.property_revenues(params[:id])
  end
end