require 'rails_helper'

RSpec.describe ChatterConversation do
  attr_reader :cc, :chat_con_hash

  before do
    @chat_con_hash = {
      :id=>104,
      :first_message_date=>"2017-06-07T02:13:29.682Z",
      :last_message_date=>"2017-06-07T02:13:29.682Z",
      :messages=>[]
    }

    @cc = ChatterConversation.new(chat_con_hash)
  end

  describe 'Attributes' do
    it 'Should have an ID' do
      expect(cc.id).to be_an Integer
      expect(cc.id).to eq chat_con_hash[:id]
    end

    it 'Should have a messages array' do
      expect(cc.messages).to be_an Array
      expect(cc.messages).to eq chat_con_hash[:messages]
    end

    it 'Should have a first message date' do
      expect(cc.first_message_date).to be_a DateTime
      expect(cc.first_message_date).to eq chat_con_hash[:first_message_date]
    end

    it 'Should have a last message date' do
      expect(cc.last_message_date).to be_a DateTime
      expect(cc.last_message_date).to eq chat_con_hash[:last_message_date]
    end
  end

  describe 'Methods' do
    describe '#find' do
      attr_reader :convo

      before do
        @convo = ChatterConversation.find(cc.id)
      end

      it 'Finds a conversation by cid' do
        expect(convo.id).to eq cc.id
      end

      it 'Returns a conversation object' do
        expect(convo).to be_a ChatterConversation
      end
    end
  end
end
