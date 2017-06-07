require 'rails_helper'

RSpec.feature  "an admin visiting the admin properties path" do
  scenario "can delete an active property" do
    admin = create(:user, role: 1, active?: true)

    login(admin)

    property = create(:property)

    visit admin_properties_path

    # within("//div[@id='#{property.name.parameterize}']") do
    #   click_on "Delete"
    # end

    find('tr', text: property.name).click_button("Delete")

    within(".all_properties") do
      expect(page).to_not have_content("#{property.name}")
    end

    expect(Property.count).to eq(0)

  end

  scenario "can delete a pending property" do
    admin = create(:user, role: 1, active?: true)

    login(admin)

    property = create(:property, status: 0)

    visit admin_properties_path

    find('tr', text: property.name).click_button("Delete")

    # within("//div[@id='#{property.name.parameterize}-pending']") do
    #   click_on "Delete"
    # end

    within(".pending_properties") do
      expect(page).to_not have_content("#{property.name}")
    end

    expect(Property.count).to eq(0)


  end
end
