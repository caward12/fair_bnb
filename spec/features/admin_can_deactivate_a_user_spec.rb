require 'rails_helper'

RSpec.feature "an admin visiting the admin_users_path" do
  scenario "can deactivate a user" do
    admin = create(:user, role: 1)
    user = create(:user, first_name: "Riley", active?: true)
    
    login(admin)

    visit admin_users_path

    find('tr', text: user.first_name).click_button("Deactivate")

    db_user = User.last

    expect(db_user.active?).to be_falsey
    expect(page).to_not have_content(db_user.first_name)
    expect(page).to_not have_content(db_user.last_name)
    expect(page).to_not have_content(db_user.email)
    expect(page).to_not have_content(db_user.phone_number)
    expect(page).to_not have_content(db_user.description)
  end

end
