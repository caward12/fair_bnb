class PropertyConversation < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :cid, presence: true, uniqueness: true

  def self.fetch(args)
    user = args[:user]
    property = args[:property]

    pc = self.find_by(user: user, property: property)

    unless pc
      chatter = ChatterService.new_conversation
      pc = self.create(user: user, property: property, cid: chatter.id)
    end

    pc
  end
end