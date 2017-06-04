class AnalyticsController < ApplicationController

  def index
    @data = Reservation.reservations_by_month
    respond_to do |format|
      format.html
      format.json{
        render json: @data
      }
    end
  end

  def data
    # respond_to do |format|
    #   format.json {
    #   render json: [ 5, 10, 13, 19, 21, 25, 22, 18, 15, 13,
    #                   11, 12, 15, 20, 18, 17, 16, 18, 23, 25 ]
    #   }
    # end
  end

end