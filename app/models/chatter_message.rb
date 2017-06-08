class ChatterMessage
  attr_reader :body, :user

  def initialize(params)
    user = User.find(params[:author])

    @body = params[:body]
    @user = user
  end
end