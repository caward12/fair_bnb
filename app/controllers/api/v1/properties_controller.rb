class Api::V1::PropertiesController < ApplicationController

  def index
    render json: Property.all
  end

end
