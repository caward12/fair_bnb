class Property < ApplicationRecord
  validates :name, :number_of_guests, :number_of_beds, :number_of_rooms, :description, :price_per_night, presence: true
  validates :address, :city, :state, :zip, :image_url, :status, presence: true

  belongs_to :room_type
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  has_many :reservations
  has_many :property_availabilities

  enum status: %w(pending active archived)

  # before_save :find_address

  def format_check_in_time
    DateTime.parse(check_in_time).strftime("%l:%M%P")
  end

  def format_check_out_time
    DateTime.parse(check_out_time).strftime("%l:%M%P")
  end

  def self.search_city_date_guests(city, date, guests)
    joins(:property_availabilities).merge(PropertyAvailability.available).where("number_of_guests >= ? AND property_availabilities.date = ? AND city LIKE ?", guests, date, "%#{city}%")
  end

  def self.search_city_guests(city, guests)
    where('city LIKE ? AND number_of_guests >= ?', "%#{city}%", guests)
  end

  def self.search_date_guests(date, guests)
    joins(:property_availabilities).merge(PropertyAvailability.available).where("number_of_guests >= ? AND property_availabilities.date = ?", guests, date)
  end

  def self.search_date_city(date, city)
    joins(:property_availabilities).merge(PropertyAvailability.available).where('city LIKE ? AND property_availabilities.date = ?', "%#{city}%", date)
  end

  def self.search_date(date)
    joins(:property_availabilities).merge(PropertyAvailability.available).where('property_availabilities.date = ?', date)
  end

  def self.search_city(city)
    where('city LIKE ?', "%#{city}%")
  end

  def self.search_guests(guests)
    where("number_of_guests >= ?", guests)
  end

  def self.create_properties
    AirBnbService.create_properties.map do |raw_prop|
      byebug
      property = Property.new(name: raw_prop[:name],
                              number_of_guests: raw_prop[:name],
                              number_of_beds: raw_prop[:beds],
                              number_of_rooms: raw_prop[:bedrooms],
                              number_of_bathrooms: raw_prop[:bathrooms],
                              price_per_night: raw_prop[:localized_nightly_price],
                              lat: raw_prop[:lat],
                              long: raw_prop[:lng],
                              image_url: raw_prop[:picture_url]
                              )
      property.save
    end
  end

  def find_address
    address_params = reverse_geocoded_by :lat, :long
    update(address_params)
  end
end
