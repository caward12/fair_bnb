class User::Properties::ReservationsController < ApplicationController

  def index
    property = Property.find(params[:property_id])
    @reservations = property.reservations
  end

  def update
    property = Property.find(params[:property_id])
    reservation = Reservation.find(params[:id])
    if params[:status] == "approve"
      reservation.update(status: "confirmed")
      property.property_availabilities.make_unavailable((reservation.check_in_date).to_date, (reservation.check_out_date).to_date)
      redirect_to user_property_reservations_path(property)
    elsif params[:status] == "decline"
      reservation.update(status: "declined")
      redirect_to user_property_reservations_path(property)
    end
  end
end