require 'rails_helper'

RSpec.feature "as an admin " do
  scenario "i can see analytics page" do
    admin = create(:user, role: 1)

    login(admin)

    visit admin_analytics_path

    expect(page).to have_content("Number of Reservations by Month")
    expect(page).to have_css("#monthContainer")
    expect(page).to have_content("Reservation Revenue by Month")
    expect(page).to have_css("#chartContainer")
    expect(page).to have_content("Properties by State")
    expect(page).to have_css("#mapContainer")
    expect(page).to have_css("#tooltip")


  end
end