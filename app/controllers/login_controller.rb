class LoginController < ApplicationController

  def index
    @redirect_path = request.referrer
  end

end
