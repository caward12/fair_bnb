require 'rails_helper'

RSpec.describe ChatterMessage do
  describe 'Attributes' do
    attr_reader :cm, :user

    before do
      @user = create :user

      params = {
        body: 'Im a ChatterMessage body',
        author: user.id
      }

      @cm = ChatterMessage.new(params)
    end

    it 'Has a body' do
      expect(cm.body).to eq 'Im a ChatterMessage body'
    end

    it 'Has a user' do
      expect(cm.user).to eq user
    end
  end
end