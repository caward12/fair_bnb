require 'rails_helper'

feature "user can cancel reservation" do
  context "as a logged in user" do
    scenario "I can cancel my reservations" do
      user = create(:user)
      property = create(:property)
      create(:property_availability, property: property, date: "2017-05-16")
      create(:property_availability, property: property, date: "2017-05-17")
      reservation = create(:reservation, property: property, renter: user, status: "confirmed")

      login(user)

      visit user_reservations_path

      expect(page).to have_content("Confirmed")
      expect(page).to have_content(reservation.title)

      click_on "Cancel Reservation"

      expect(current_path).to eq(user_reservations_path)
      expect(page).to have_content("Declined")
      # expect(reservation.status).to eq("declined")

    end
  end
end