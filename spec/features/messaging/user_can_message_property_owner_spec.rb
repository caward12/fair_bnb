require 'rails_helper'

RSpec.feature "Registered user can message a property owner" do
  attr_reader :user, :property, :owner

  before do
    @user = create(:user)
    @property = create(:property)
    @owner = property.owner

    login(user)

    visit property_path(property)
  end

  context 'And a conversation does not exist' do
    scenario "So it starts a new conversation" do
      click_on "Message #{owner.first_name}"

      convo = Conversation.find_by(user: user, property: property)

      expect(current_path).to eq(conversation_path(convo))
      expect(page).to have_content("Chat between #{user.first_name} and #{owner.first_name} about #{property.name}")
      expect(page).to have_link property.name

      expect(page).to have_selector('.conversation-messages:empty')
    end
  end

  context 'And a conversation exists' do
    scenario 'So it resumes the old conversation' do
      convo = create :conversation, property: property, user: user
      message = convo.messages.first

      click_on "Message #{owner.first_name}"

      expect(current_path).to eq(conversation_path(convo))
      expect(page).to have_content("Chat between #{user.first_name} and #{owner.first_name} about #{property.name}")
      expect(page).to have_link property.name

      within '.conversation-messages' do
        within '.message:first' do
          expect(page).to have_content message.body
          expect(page).to have_content message.author
        end
      end
    end
  end
end
