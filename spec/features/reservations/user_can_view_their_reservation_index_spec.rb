require 'rails_helper'

feature "user reservation index page" do
  attr_reader :user, :user2
  before :each do
    @user = create(:user_with_reservations)
    @user2 = create(:user_with_reservations)
  end
  context "as a guest" do
    scenario "guest should not be able to navigate to my reservations" do
      visit root_path

      expect(page).to_not have_link("My Reservations")
    end
    scenario "guest should receive a 404" do
      visit user_reservations_path

      expect(page.status_code).to eq(404)

      within '.alert' do
        expect(page).to have_content("Page not found!")
      end
    end
  end
  context "as a logged in user" do
    scenario "should be able to navigate to my reservations" do
      login(user)

      expect(page).to have_link("My Reservations")

      click_link "My Reservations"

      expect(current_path).to eq(user_reservations_path)

      logout
    end
    scenario "return a collection of my reservations" do
      login(user)
      visit user_reservations_path



      %w(pending confirmed in_progress finished declined).each do |status|
        within(".#{status}") do
          reservation = user.reservations.find_by(status: status)
          expect(page).to have_selector('.reservation', count: 1)
          expect(page).to have_css("img[src*='#{reservation.property.image_url}']")
          expect(page).to have_link(reservation.property.city)
          expect(page).to have_content(reservation.title)
          expect(page).to have_content(reservation.check_in_date)
          expect(page).to have_content(reservation.check_out_date)
          expect(page).to have_content("#{reservation.number_of_guests} guest")
        end
      end

      logout
    end
    scenario "i cannot navigate to another user's reservations" do
      login(user2)
      visit user_reservations_path

      %w(pending confirmed in_progress finished declined).each do |status|
        within(".#{status}") do
          reservation = user.reservations.find_by(status: status)
          expect(page).to_not have_css("img[src*='#{reservation.property.image_url}']")
          expect(page).to_not have_link(reservation.property.city)
          expect(page).to_not have_content(reservation.title)
        end
      end
    end
  end
end
