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

  def renter_name
    renter.full_name
  end

  def host
    property.owner
  end

  def host_name
    host.full_name
  end

  def print_status
    return status.capitalize unless status == 'in_progress'
    "In Progress"
  end

  def format_total_price
    "$#{total_price.to_f.round(2)}"
  end

  def nights
    pluralize((end_date - start_date).to_i, 'night')
  end

  def self.find_by_user(user_id, id)
    r = find(id)
    return r if (r.host.id == user_id) || (r.renter.id == user_id)
  end

  def self.generate_booking(attrs = {}, user_id)
    decider, msg, params = check_valid_booking_params(attrs, user_id)
    if decider
      new(params)
    else
      msg
    end
  end

  def self.check_valid_booking_params(attrs, user_id)
    start_date = attrs[:check_in_date].to_date rescue nil
    end_date = attrs[:check_out_date].to_date rescue nil
    if start_date.nil? || end_date.nil?
      return false, "Please fill out valid check in and check out dates.", {}
    elsif start_date == end_date
      return false, "Check in date cannot be the same as check out date.", {}
    elsif start_date > end_date
      return false, "Reservation check in and out dates are not sequential.", {}
    else
      property_id = attrs[:property_id]
      price_per_night = Property.find(property_id).price_per_night
      total_price = (end_date - start_date).to_i * price_per_night
      params = {
        total_price: total_price,
        start_date: start_date,
        end_date: end_date,
        number_of_guests: attrs[:guests].to_i,
        property_id: property_id,
        renter_id: user_id
      }
      return true, "", params
    end
  end

end
