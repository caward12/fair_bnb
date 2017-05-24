class ReservationsController < ApplicationController
  before_action :check_user_sign_in

  def index
    @reservations = ReservationsPresenter.new(current_user)
  end

  def show
    @reservation = Reservation.find_by_user(current_user.id, params[:id])
    redirect_page_not_found if @reservation.nil?
  end

end
