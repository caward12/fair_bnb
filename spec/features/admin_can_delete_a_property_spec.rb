require 'rails_helper'

RSpec.feature  "an admin visiting the admin properties path" do
  scenario "can delete an active property" do
    admin = create(:user, role: 1, active?: true)

    login(admin)

    property = create(:property)

    visit admin_properties_path

    find('tr', text: property.name).click_button("Delete")


    expect(page).to_not have_content("#{property.name}")


    expect(Property.count).to eq(0)

  end

  scenario "can delete a pending property" do
    admin = create(:user, role: 1, active?: true)

    login(admin)

    property = create(:property, status: 0)

    visit admin_properties_path

    find('tr', text: property.name).click_button("Delete")


    expect(page).to_not have_content("#{property.name}")
    
    expect(Property.count).to eq(0)


  end
end
