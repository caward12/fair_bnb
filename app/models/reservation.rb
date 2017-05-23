class Reservation < ApplicationRecord
  validates :total_price, :start_date, :end_date, :number_of_guests, :status, presence: true

  belongs_to :property
  belongs_to :renter, class_name: "User", foreign_key: "renter_id"

  enum status: %w(pending confirmed in_progress finished declined)

  def city
    property.city
  end

  def check_in_date
    start_date.strftime("%b %d, %Y")
  end

  def check_out_date
    end_date.strftime("%b %d, %Y")
  end

  def guests
    pluralize(number_of_guests, 'guest')
  end

  def title
    property.name
  end

  def image_url
    property.image_url
  end

end
