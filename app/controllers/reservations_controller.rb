class ReservationsController < ApplicationController
  before_action :check_user_sign_in

  def index
    @reservations = ReservationPresenter.new(current_user)
  end

end
