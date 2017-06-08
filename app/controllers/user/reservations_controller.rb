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
    if @reservation.is_a?(String)
      flash[:warning] = @reservation
      redirect_to property_path(booking_params[:property_id])
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    FriendNotifier.inform(current_user, @reservation).deliver_now

    flash[:notice] = "Your reservation is placed."
    if @reservation.save
     
      flash[:success] = "Reservation request successful and awaiting approval from host."
      redirect_to user_reservation_path(@reservation)
    end
  end

  def update
    reservation = Reservation.find(params[:id])
    property = reservation.property
    if params[:status] == "declined"
      reservation.update(status: "declined")
      property.property_availabilities.make_available((reservation.check_in_date).to_date, (reservation.check_out_date).to_date)
      flash[:success] = "Reservation was successfully canceled."
      redirect_to user_reservations_path
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
