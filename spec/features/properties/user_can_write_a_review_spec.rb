require 'rails_helper'

RSpec.feature "as a user I can write a review for a property" do
  before do
    @property = create(:property)
  end
  scenario "when I click on the reviews tab I see a field to rate a property 1-5 and a text field to write a review" do

    visit property_path(@property)

    click_on "Reviews"
    expect(page).to have_field("review[rating]")
    expect(page).to have_field("review[comment]")
  end
end
