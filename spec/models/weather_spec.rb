require 'rails_helper'

describe Weather do
  it "returns weather conditions for a location" do
    VCR.use_cassette('weather', record: :new_episodes) do
      property = create(:property, city: "New York", state: "NY")
      property1 = create(:property, city: "Chickasha", state: "OK")
      weather = property.get_weather
      weather1 = property1.get_weather

      expect(weather.class).to eq(Weather)
      expect(weather.conditions).to eq("Overcast")
      expect(weather.temperature).to eq("57.9 F (14.4 C)")
      expect(weather.wind).to eq("Calm")
      expect(weather1.conditions).to eq("Clear")
      expect(weather1.temperature).to eq("90 F (32 C)")
      expect(weather1.wind).to eq("From the South at 7 MPH")
    end
  end
end
