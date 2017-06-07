require 'rails_helper'

RSpec.describe ChatterService do
  describe '#new_conversation' do
    it 'Returns a new ChatterConversation' do
      convo = ChatterService.new_conversation

      expect(convo).to be_a ChatterConversation
      expect(convo.messages.empty?).to be true
    end
  end
end