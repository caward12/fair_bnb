class FriendNotifier < ApplicationMailer

  def inform(user, reservation)
    @user = user
    @reservation = reservation
    mail(to: user['email'], subject: "Fair-bnb reservation.")
  end

  def inform_before(user, reservation)
    @user = user
    @reservation = reservation
    mail(to: user['email'], subject: "Your Fair-bnb reservation starts in 24 hours.")
  end

  def inform_status(user, reservation)
    @user = user
    @reservation = reservation
    mail(to: user['email'], subject: "Your Fair-bnb reservation is #{reservation.status}")
  end
end