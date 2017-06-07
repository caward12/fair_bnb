require 'rails_helper'

RSpec.describe ChatterService do
  describe '#new_conversation' do
    it 'Returns a new ChatterConversation' do
      convo = ChatterService.new_conversation

      expect(convo).to be_a ChatterConversation
      expect(convo.messages.empty?).to be true
    end
  end

  describe '#find_conversation' do
    it 'Finds a ChatterConversation by cid' do
      convo = ChatterService.find_conversation(104)

      expect(convo).to be_a Hash
      expect(convo[:id]).to eq 104
    end
  end
end