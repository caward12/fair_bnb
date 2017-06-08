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
      VCR.use_cassette 'conversations/start_new_convo' do
        click_on "Message #{owner.first_name}"

        expect(current_path).to eq(property_conversation_path(property, user))
        expect(page).to have_content("Chat between #{owner.full_name} & #{user.full_name} about #{property.name}")
        expect(page).to have_link property.name

        within '.conversation-messages' do
          expect(page).to have_selector('.message', count: 0)
        end
      end
    end
  end

  context 'And a conversation exists' do
    scenario 'So it resumes the old conversation' do
      VCR.use_cassette 'conversations/resume_conversation' do
        click_on "Message #{owner.first_name}"

        expect(current_path).to eq(property_conversation_path(property, user))
        expect(page).to have_content("Chat between #{user.full_name} & #{owner.full_name} about #{property.name}")
        expect(page).to have_link property.name

        # You can't test web sockets like this
        # within '.conversation-messages' do
        #   within '.message:first' do
        #     expect(page).to have_content 'Hi, friend!'
        #     expect(page).to have_content user.first_name
        #   end
        # end
      end
    end
  end
end
