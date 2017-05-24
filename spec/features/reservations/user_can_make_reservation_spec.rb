require 'rails_helper'

feature "request to book" do
  attr_reader :user,
              :property,
              :check_in_date,
              :check_in_format,
              :check_out_date,
              :check_out_format,
              :total_price
  before :each do
    @user = create(:user)
    @property = create(:property_with_availability)
    @check_in_date = @property.property_availabilities.first.date.strftime("%Y-%m-%d")
    @check_in_format = @check_in_date.to_date.strftime("%b %d, %Y")
    @check_out_date = @property.property_availabilities.last.date.strftime("%Y-%m-%d")
    @check_out_format = @check_out_date.to_date.strftime("%b %d, %Y")
    @total_price = @property.price_per_night * 2.0
  end
  context "as a guest user" do
    xscenario "prompted to login when attempting to book" do
      visit property_path(property)
      make_reservation

      expect(current_path).to eq(log_in_path)
      within ".alert" do
        "Please log in or sign up to continue with your booking!"
      end
    end
    xscenario "once logged in, i am redirected back to the reservation booking page" do
      visit property_path(property)
      make_reservation

      login(user)

      expect(current_path).to eq(property_path(property))
    end
  end
  context "as a logged in user" do
    scenario "directed to booking page" do
      login(user)
      visit property_path(property)
      make_reservation

      expect(current_path).to eq(new_user_reservation_path)
      expect(page).to have_content("Complete your Reservation")
      expect(page).to have_css("img[src*='#{property.image_url}']")
      expect(page).to have_content("Total Cost: $#{total_price.round(2)}")
      expect(page).to have_content("#{check_in_format} - #{check_out_format}")
      expect(page).to have_content("2 nights at #{property.name}")
      expect(page).to have_content("for 1 guest")
      expect(page).to have_button("Complete Booking")

      click_on "Complete Booking"

      expect(current_path).to eq(user_reservation_path(Reservation.last))

      within ".alert" do
        expect(page).to have_content("Reservation request successful and awaiting approval from host.")
      end

    end
    xscenario "user booking edge cases" do
      # cannot book with check-in-date same as check-out-date
      # cannot book with check-out-date before check-in-date
      # must book with check-in, check-out, and guests in form (make required?)
    end
    xscenario "pending booking shows up in user's reservations" do
      login(user)
      expect(user.reservations.count).to eq(0)

      visit property_path(property)
      make_reservation
      click_on "Complete Booking"
      visit user_reservations_path

      expect(user.reservations.count).to eq(1)

      within(".#{pending}") do
        expect(page).to have_selector('.reservation', count: 1)
        expect(page).to have_css("img[src*='#{property.image_url}']")
        expect(page).to have_link(property.city)
        expect(page).to have_content(property.title)
        expect(page).to have_content(check_in_date)
        expect(page).to have_content(check_out_date)
        expect(page).to have_content("1 guest")
      end
    end
    xscenario "cannot book a place if unavailable" do
      property2 = create(:property_with_reservations)
      check_in_date2 = property2.property_availabilities.first.date.strftime("%Y-%m-%d")
      check_out_date2 = property2.property_availabilities.last.date.strftime("%Y-%m-%d")

      login(user)
      visit property_path(property)

      fill_in :check_in_date, with: check_in_date2
      fill_in :check_out_date, with: check_out_date2
      fill_in :guests, with: 1
      click_on "Request to Book"

      expect(current_path).to eq(property_path(property))

      within ".alert" do
        expect(page).to have_content("Property is unavailable for those dates! Try searching again with your check-in dates above.")
      end

      expect(user.reservations.count).to eq(0)
    end
  end
end
