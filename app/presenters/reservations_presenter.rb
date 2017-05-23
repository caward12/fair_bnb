class ReservationsPresenter

  def initialize(user)
    @user = user
    @reservations = user.reservations
  end

  def status_collection(status)
    reservations.where(status: status)
  end

  def got_status?(status)
    !status_collection(status).empty?
  end

  def print_status(status)
    return status.capitalize unless status == 'in_progress'
    "In Progress"
  end

  private
    attr_reader :reservations, :user

end
