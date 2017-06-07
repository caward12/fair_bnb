require 'rails_helper'

RSpec.describe PropertyConversation do
  attr_reader :user, :property, :cid

  before do
    @user = create :user
    @property = create :property
    @cid = '1'
  end

  describe 'Validations' do
    it 'Is invalid without a user' do
      pc = PropertyConversation.new(property: property, cid: cid)

      expect(pc).to_not be_valid
    end

    it 'Is invalid without a property' do
      pc = PropertyConversation.new(user: user, cid: cid)

      expect(pc).to_not be_valid
    end

    it 'Is invalid without a chatter id' do
      pc = PropertyConversation.new(user: user, property: property)

      expect(pc).to_not be_valid
    end

    it 'Is valid with a user, property and chatter id' do
      pc = PropertyConversation.new(user: user, property: property, cid: cid)

      expect(pc).to be_valid
    end
  end

  describe 'Relationships' do
    it 'Has a user' do
      pc = PropertyConversation.create(user: user, property: property, cid: cid)

      expect(pc.user).to be user
    end

    it 'Has a property' do
      pc = PropertyConversation.create(user: user, property: property, cid: cid)

      expect(pc.property).to be property
    end
  end

  describe 'Methods' do
    describe '#fetch' do
      it 'Creates a new conversation if one doesnt exist' do
        pc = PropertyConversation.find_by(user: user, property: property)

        expect(pc).to be nil

        pc = PropertyConversation.fetch(user: user, property: property)

        expect(pc).to eq PropertyConversation.last
      end

      it 'Retrieves the conversation if it exists' do
        PropertyConversation.create(user: user, property: property)

        pc = PropertyConversation.fetch(user: user, property: property)

        expect(pc).to eq PropertyConversation.last
      end
    end
  end
end
