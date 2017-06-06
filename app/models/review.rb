class Review < ApplicationRecord
  belongs_to :property
  belongs_to :user

  validates_presence_of :rating
  validates_presence_of :comment
end
