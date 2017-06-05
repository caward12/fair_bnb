class FriendNotifier < ApplicationMailer
  def inform(user)
    mail(to: user['email'], subject: "you've changed.")
  end
end