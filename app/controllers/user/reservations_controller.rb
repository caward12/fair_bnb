class User::ReservationsController < ApplicationController
  before_action :check_user_sign_in

  def index
    @reservations = ReservationsPresenter.new(current_user)
  end

  def show
    @reservation = Reservation.find_by_user(current_user.id, params[:id])
    redirect_page_not_found if @reservation.nil?
  end

  def new
    @reservation = Reservation.generate_booking(booking_params, current_user.id)
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      flash[:success] = "Reservation request successful and awaiting approval from host."
      redirect_to user_reservation_path(@reservation)
    end
  end

  private
    def booking_params
      params.permit(:check_in_date, :check_out_date, :guests, :property_id)
    end

    def reservation_params
      params.require(:reservation).permit(:total_price,
                                          :start_date,
                                          :end_date,
                                          :number_of_guests,
                                          :property_id,
                                          :renter_id)
    end

end
