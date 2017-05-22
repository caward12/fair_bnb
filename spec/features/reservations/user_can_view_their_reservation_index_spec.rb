require 'rails_helper'

feature "user reservation index page" do
  context "as a guest" do
    scenario "guest should not be able to navigate to my reservations" do
      visit root_path

      expect(page).to_not have_link("My Reservations")
    end
    scenario "guest should receive a 404" do
      visit user_reservations_path

      expect(response.status).to eq(404)

      within '.alert-error' do
        page.should have_content("Page page_not_found doesn't exist")
      end
    end
  end
  context "as a logged in user" do
    attr_reader :user, :pending, :confirmed, :in_progress, :finished, :declined
    before :each do
      user = create(:user_with_reservations)
      pending = user.reservations.find_by(status: 0)
      confirmed = user.reservations.find_by(status: 1)
      in_progress = user.reservations.find_by(status: 2)
      finished = user.reservations.find_by(status: 3)
      declined = user.reservations.find_by(status: 4)
    end
    scenario "should be able to navigate to my reservations" do
      login(user)

      expect(page).to have_link("My Reservations")

      click_link "My Reservations"

      expect(current_path).to eq(user_reservations_path)
    end
    scenario "return a collection of my reservations" do
      login(user)
      visit user_reservations_path

      within(".pending") do
        expect(page).to have_content()
      end

    end
    scenario "i cannot navigate to another user's reservations" do

    end
  end
end
