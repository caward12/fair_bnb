class Admin::AnalyticsController < ApplicationController

  def index

  end

  def update
    @city = params["City"]
    redirect_to admin_analytics_path
  end

end