require 'rails_helper'

RSpec.describe ChatterConversation do
  attr_reader :cc, :chat_con_hash

  before do
    user = create :user

    @chat_con_hash = {
      :id=>104,
      :first_message_date=>"2017-06-07T02:13:29.682Z",
      :last_message_date=>"2017-06-07T02:13:29.682Z",
      :messages=>[{
        body: 'Argle barf?',
        author: user.id
        }]
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
      expect(cc.messages.count).to eq chat_con_hash[:messages].count
      expect(cc.messages.first).to be_a ChatterMessage
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
    describe '#new' do
      it 'Should return a new, empty conversation if no args are given' do
        new_convo = ChatterConversation.new
        expect(new_convo).to be_a ChatterConversation
        expect(new_convo.messages.empty?).to be true
      end
    end

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

    describe '#post_message' do
      attr_reader :params

      before do
        user = create :user
        convo = ChatterConversation.new

        @params = {
          conversation_id: convo.id,
          author: user.id,
          body: 'YOLO'
        }
      end

      it 'Adds a message to a conversation' do
        VCR.use_cassette 'conversations/#post_message' do
          convo = ChatterConversation.find(params[:conversation_id])

          expect(convo.messages.empty?).to be true

          ChatterConversation.post_message(params)

          convo = ChatterConversation.find(params[:conversation_id])

          expect(convo.messages.empty?).to be false
          expect(convo.messages.last.body).to eq 'YOLO'
        end
      end

      it 'Returns a message object' do
        VCR.use_cassette 'conversations/#post_message_returns_Message' do
          response = ChatterConversation.post_message(params)
          user = User.find(params[:author])

          expect(response).to be_a ChatterMessage
          expect(response.body).to eq params[:body]
          expect(response.author).to be user
        end
      end
    end
  end
end
