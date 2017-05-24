class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  
  # validates :name, presence: true
  # before_validation :set_name
  # 
  # def set_name
  #   self.name = "user-#{current_user.id}-#{}" # for path: URI.escape(self.title).gsub('%20','-')
  # end
end
