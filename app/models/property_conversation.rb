class PropertyConversation < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :cid, presence: true, uniqueness: true
end