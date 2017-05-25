class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  
  # validates :name, presence: true
  # before_validation :set_name
  # 
  # def set_name
  #   self.name = "user-#{current_user.id}-#{}" # for path: URI.escape(self.title).gsub('%20','-')
  # end
  
  def parse_name
    name.split("-")
  end
  
  def first_user_id
    parse_name[1]
  end
  
  def second_user_id
    parse_name[2]
  end
  
  def self.find_by_user(id)
    all.map do |convo|
      if convo.parse_name[1] == id.to_s || convo.parse_name[2] == id.to_s
        convo
      end
    end
  end
end
