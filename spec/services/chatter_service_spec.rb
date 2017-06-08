require 'rails_helper'

RSpec.describe ChatterService do
  attr_reader :new_convo

  before do
    VCR.use_cassette 'conversations/new_convo_for_tests' do
      @new_convo = ChatterConversation.new
    end
  end

  describe '#new_conversation' do
    it 'Returns a new ChatterConversation' do
      VCR.use_cassette 'conversations/service#new_conversation' do
        convo = ChatterService.new_conversation

        expect(convo).to be_a Hash
        expect(convo).to have_key :id
        expect(convo).to have_key :messages
        expect(convo).to have_key :first_message_date
        expect(convo).to have_key :last_message_date

        expect(convo[:messages].empty?).to be true
      end
    end
  end

  describe '#find_conversation' do
    it 'Finds a ChatterConversation by cid' do
      VCR.use_cassette 'conversations/service#find_conversation' do
        convo = ChatterService.find_conversation(new_convo.id)

        expect(convo).to be_a Hash
        expect(convo[:id]).to eq new_convo.id
      end
    end
  end

  describe '#post_message' do
    it 'Posts a message to a conversation' do
      VCR.use_cassette 'conversations/service#post_message' do
        user = create :user
        params = {
          cid: new_convo.id,
          body: 'Im another ChatterMessage body',
          author: user.id
        }

        ChatterService.post_message(params)
        convo = ChatterConversation.find(params[:cid])

        expect(convo.messages.last.body).to eq params[:body]
        expect(convo.messages.last.user).to eq user
      end
    end

    it 'Returns a hash' do
      VCR.use_cassette 'conversations/service#post_message_returns_a_hash' do
        user = create :user
        params = {
          cid: new_convo.id,
          body: 'Im another ChatterMessage body',
          author: user.id
        }

        response = ChatterService.post_message(params)

        expect(response).to be_a Hash

        expect(response).to have_key :body
        expect(response).to have_key :author

        expect(response[:body]).to eq params[:body]
        expect(response[:author]).to eq params[:author].to_s
      end
    end
  end
end
