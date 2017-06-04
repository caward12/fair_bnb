require 'rails_helper'

RSpec.feature "as a user I can write a review for a property" do
  before do
    @property = create(:property)
    @user = create(:user)
  end
  scenario "when I click on the reviews tab I see a field to rate a property 1-5 and a text field to write a review" do

    visit property_path(@property)

    click_on "Reviews"
    expect(page).to have_field("review[rating]")
    expect(page).to have_field("review[comment]")
  end

  scenario "i fill out form fields and create a review" do
    login(@user)

    visit property_path(@property)
    click_on "Reviews"
    fill_in "review[rating]", with: 5
    fill_in "review[comment]", with: "Great Home"
    click_on "Submit"

    expect(Review.last.rating).to eq(5)
    expect(Review.last.comment).to eq("Great Home")
    expect(current_path).to eq(property_path(@property))
  end
end
