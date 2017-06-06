class ReviewsController < ApplicationController

  def create
    @property = Property.find(params[:property_id])
    @review = @property.reviews.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to property_path(@property), notice: 'Review was successfully created.' }
        format.json { render json: @review.json_presenter, status: :created }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment).merge(user_id: current_user.id)
  end

end
