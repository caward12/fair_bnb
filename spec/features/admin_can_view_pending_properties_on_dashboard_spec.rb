require 'rails_helper'

RSpec.feature "as an admin " do
  scenario "i can see pending properties" do
    admin = create(:user, role: 1)
    property = create(:property, status: 0)
    login(admin)

    visit admin_dashboard_index_path


    click_on "Properties"

    expect(current_path).to eq(admin_properties_path)


    expect(page).to have_content(property.name)
    expect(page).to have_selector(:link_or_button, 'Activate')
  end

  scenario "i can change the status of a pending property to active" do
    admin = create(:user, role: 1)
    property = create(:property, status: 0)
    login(admin)

    visit admin_properties_path


      click_on "Activate"
      db_property = Property.last
      expect(db_property.status).to eq("active")
  end
end
