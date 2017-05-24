require 'rails_helper'

RSpec.feature "Registered user can message a property owner" do
  scenario "and it starts a new conversation" do
    user = create(:user)
    property = create(:property)
    user2 = property.owner
    login(user)
    
    visit property_path(property)
    click_on "Message #{user2.first_name}"
    
    expect(current_path).to eq(conversation_path(user, user2))
    expect(page).to have_content
  end
end