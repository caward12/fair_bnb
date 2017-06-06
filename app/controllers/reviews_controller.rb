class ReviewsController < ApplicationController

  def create
    @property = Property.find(params[:property_id])
    @review = @property.reviews.new(review_params)

    respond_to do |format|
      if @review.update(user_id: current_user.id)
        format.html { redirect_to property_path(@property), notice: 'Review was successfully created.' }
        format.js   { }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

end
