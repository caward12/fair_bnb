require 'rails_helper'

feature "owner can approve reservation" do
  context "as a loggin in user with properties" do
    scenario "I can approve pending reservations" do
      user = create(:user)
      user2 = create(:user)
      property = create(:property, owner: user2)
      create(:property_availability, property: property, date: "2017-05-16")
      create(:property_availability, property: property, date: "2017-05-17")
      reservation = create(:reservation, property: property, renter: user, status: "pending")

      login(user2)

      visit user_property_reservations_path(property)

      expect(reservation.status).to eq("pending")
      expect(page).to have_content("Reservations for #{property.name}")
      expect(page).to have_link("#{user.full_name}")
      expect(page).to have_content("Current status: pending")

      click_on "Approve"

      expect(current_path).to eq(user_property_reservations_path(property))
      expect(page).to have_content("Current status: confirmed")
      # expect(reservation.status).to eq("confirmed")

    end

    scenario "I can decline pending reservations" do
      user = create(:user)
      user2 = create(:user)
      property = create(:property, owner: user2)
      create(:property_availability, property: property, date: "2017-05-16")
      create(:property_availability, property: property, date: "2017-05-17")
      reservation = create(:reservation, property: property, renter: user, status: "pending")

      login(user2)

      visit user_property_reservations_path(property)

      expect(reservation.status).to eq("pending")
      expect(page).to have_content("Reservations for #{property.name}")
      expect(page).to have_link("#{user.full_name}")
      expect(page).to have_content("Current status: pending")

      click_on "Decline"

      expect(current_path).to eq(user_property_reservations_path(property))
      expect(page).to have_content("Current status: declined")
      # expect(reservation.status).to eq("declined")

    end

    scenario "I can approve reservation and it updates property availability" do
      user = create(:user)
      user2 = create(:user)
      property = create(:property, owner: user2)
      create(:property_availability, property: property, date: "2017-05-16")
      create(:property_availability, property: property, date: "2017-05-17")
      reservation = create(:reservation, property: property, renter: user, status: "pending")

      login(user2)

      visit user_property_reservations_path(property)

      expect(reservation.status).to eq("pending")
      expect(page).to have_content("Reservations for #{property.name}")
      expect(page).to have_link("#{user.full_name}")
      expect(page).to have_content("Current status: pending")

      click_on "Approve"

      expect(current_path).to eq(user_property_reservations_path(property))
      expect(page).to have_content("Current status: confirmed")
      expect(property.property_availabilities.first.reserved?).to eq(true)
      expect(property.property_availabilities.last.reserved?).to eq(true)


    end
  end
end

# xscenario "once a reservation is booked the property is no longer available for those days" do
#
# end
