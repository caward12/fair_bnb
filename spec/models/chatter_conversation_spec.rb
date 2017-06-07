require 'rails_helper'

RSpec.describe ChatterConversation do
  attr_reader :cc, :chat_con_hash

  before do
    @chat_con_hash = {
      :id=>104,
      :first_message_date=>"2017-06-07T02:13:29.682Z",
      :last_message_date=>"2017-06-07T02:13:29.682Z",
      :messages=>[{
        body: 'Argle barf?',
        author: 7
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
      expect(cc.messages).to eq chat_con_hash[:messages]
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
        @params = {
          conversation_id: 22,
          author: 1,
          body: 'YOLO'
        }
      end

      it 'Adds a message to a conversation' do
        VCR.use_cassette 'conversations/#post_message' do
          convo = ChatterConversation.find(params[:conversation_id])

          expect(convo.messages.last.body).to_not eq 'YOLO'

          ChatterConversation.post_message(params)

          convo = ChatterConversation.find(params[:conversation_id])

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
