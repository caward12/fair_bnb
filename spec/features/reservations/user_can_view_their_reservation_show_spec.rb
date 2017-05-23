require 'rails_helper'

feature "reservation show page" do
  attr_reader :renter1, :owner1, :reservation, :renter2, :owner2
  before :each do
    @renter1 = create(:user_with_reservations)
    @owner1 = @renter1.property.owner
    @reservation = renter1.reservations.find_by(status: 0)
    @renter2 = create(:user_with_reservations)
    @owner2 = @renter2.property.owner
  end
  scenario "guest cannot access a reservation show page" do
    visit user_reservation_path(@renter1.reservations.first)

    expect(page.status_code).to eq(404)

    within '.alert' do
      expect(page).to have_content("Page not found!")
    end
  end
  xscenario "renter can navigate to a reservation show from index" do
    login(renter1)

    click_link "My Reservations"

    within(".pending") do
      click_link reservation.city
    end

    expect(current_path).to eq(user_reservation_path(reservation))
  end
  xscenario "owner can navigate to a reservation show from property reservations index" do
      # to be built out later
      # login(owner1)
      # click_link "My Properties"
      # click_link "Reservations"
      # expect(current_path).to eq(user_reservation_path(reservation))
  end
  xscenario "owner can access a reservation show" do
    login(owner1)

    visit user_reservation_path(reservation)

    expect(current_path).to eq(user_reservation_path(reservation))
    expect(page.status_code).to eq(200)
  end
  scenario "renter can access a reservation show" do
    login(renter1)

    visit user_reservation_path(reservation)

    expect(current_path).to eq(user_reservation_path(reservation))
    expect(page.status_code).to eq(200)

    within "h1" do
      expect(page).to have_content("Reservation for #{renter.name} in #{reservation.city}:")
    end
    expect(page).to have_css("img[src*='#{reservation.property.image_url}']")
    expect(page).to have_content("Status: Pending")
    expect(page).to have_content("Status: Pending")

  end
  xscenario "random user cannot access another renter/owner's reservatin" do

  end
end
