require 'rails_helper'

RSpec.describe ChatterMessage do
  describe 'Attributes' do
    attr_reader :cm

    before do
      user = create :user

      params = {
        body: 'Im a ChatterMessage body',
        author: user.id
      }

      @cm = ChatterMessage.new(cm)
    end

    it 'Has a body' do
      expect(cm.body).to eq 'Im a ChatterMessage body'
    end

    it 'Has an author' do
      expect(cm.user).to be user
    end
  end
end