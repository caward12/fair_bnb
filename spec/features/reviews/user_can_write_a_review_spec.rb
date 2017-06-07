require 'rails_helper'

RSpec.feature "as a user I can write a review for a property" do
  before do
    @property = create(:property)
    @user = create(:user)
  end
  scenario "when I click on the reviews tab I see a form to write a review" do
    login(@user)
    visit property_path(@property)

    click_on "Reviews"
    expect(page).to have_css("#new_review")
  end
end
