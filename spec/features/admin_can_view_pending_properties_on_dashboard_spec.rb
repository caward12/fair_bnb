require 'rails_helper'

RSpec.feature "as an admin " do
  xscenario "i can see pending properties" do
    admin = create(:user, role: 1)
    property = create(:property, status: 0)
    login(admin)

    visit admin_dashboard_index_path

    within (".collapse") do
      click_on "Admin Menu"
      click_on "Properties"
    end

    expect(current_path).to eq(admin_properties_path)


    expect(page).to have_content(property.name)
    expect(page).to have_selector(:link_or_button, 'Activate')
  end

  xscenario "i can change the status of a pending property to active" do
    admin = create(:user, role: 1)
    property = create(:property, status: 0)
    login(admin)

    visit admin_properties_path


      expect(page).to have_content(property.name)
      click_on "Activate"



      expect(page).to_not have_content(property.name)



      expect(page).to have_content(property.name)

  end
end
