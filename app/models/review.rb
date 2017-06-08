class Review < ApplicationRecord
  belongs_to :property
  belongs_to :user

  validates_presence_of :rating
  validates_presence_of :comment

    def json_presenter
      {
        rating: rating,
        comment: comment,
        image: user.image_url,
        name: user.full_name,
        date: date
      }
    end

    def date
      created_at.strftime("%B %Y")
    end
end
