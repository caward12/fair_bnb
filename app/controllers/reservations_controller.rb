class ReservationsController < ApplicationController
  before_action :check_user_sign_in

  def index
    @reservations = ReservationsPresenter.new(current_user)
  end

  def show
    @reservation = current_user.reservations.find(params[:id])
  end

end
