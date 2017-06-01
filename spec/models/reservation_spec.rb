require 'rails_helper'

RSpec.describe Reservation, type: :model do
  context "reservation is valid with all attributes" do
    before do
      room_type = create(:room_type)
      @property = create(:property, room_type: room_type)
      @user = create(:user)
    end

    it { should validate_presence_of(:total_price) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:number_of_guests) }
    it { should validate_presence_of(:status) }
    it { should belong_to :property }
    it { should belong_to :renter }
  end

  describe "validations" do
    it "is invalid without total_price" do
      reservation = build(:reservation, total_price: nil, renter: @user, property: @property)
      expect(reservation).to_not be_valid
    end
    it "is invalid without start_date" do
      reservation = build(:reservation, start_date: nil, renter: @user, property: @property)
      expect(reservation).to_not be_valid
    end
    it "is invalid without end_date" do
      reservation = build(:reservation, end_date: nil, renter: @user, property: @property)
      expect(reservation).to_not be_valid
    end
    it "is invalid without number_of_guests" do
      reservation = build(:reservation, number_of_guests: nil, renter: @user, property: @property)
      expect(reservation).to_not be_valid
    end
    it "is invalid without status" do
      reservation = build(:reservation, status: nil, renter: @user, property: @property)
      expect(reservation).to_not be_valid
    end
    it "is invalid without renter" do
      reservation = build(:reservation, renter: nil, property: @property)
      expect(reservation).to_not be_valid
    end
    it "is invalid without property" do
      reservation = build(:reservation, property: nil, renter: @user)
      expect(reservation).to_not be_valid
    end
  end
end

describe "model methods" do
  before :each do
    @reservation = create(:reservation)
    @reservation2 = create(:reservation, number_of_guests: 2, end_date: Date.new(2017, 5, 18))
    @property = @reservation.property
  end
  it "returns reservation's property's city" do
    expect(@reservation.city).to eq(@property.city)
  end
  it "returns formatted check in and check out dates" do
    expect(@reservation.check_in_date).to eq("May 16, 2017")
    expect(@reservation.check_out_date).to eq("May 17, 2017")
  end
  it "returns pluralized guests" do
    expect(@reservation.guests).to eq("1 guest")
    expect(@reservation2.guests).to eq("2 guests")
  end
  it "returns reservation's property's name" do
    expect(@reservation.title).to eq(@property.name)
  end
  it "returns reservation's property's image" do
    expect(@reservation.image_url).to eq(@property.image_url)
  end
  it "returns reservation's renter's name" do
    expect(@reservation.renter_name).to eq(@reservation.renter.full_name)
  end
  it "returns reservation's property's owner" do
    expect(@reservation.host).to eq(@reservation.property.owner)
    expect(@reservation.host_name).to eq(@reservation.property.owner.full_name)
  end
  it "returns humanized versions of reservation statuses" do
    r0 = create(:reservation, status: 0)
    r1 = create(:reservation, status: 1)
    r2 = create(:reservation, status: 2)
    r3 = create(:reservation, status: 3)
    r4 = create(:reservation, status: 4)
    expect(r0.print_status).to eq("Pending")
    expect(r1.print_status).to eq("Confirmed")
    expect(r2.print_status).to eq("In Progress")
    expect(r3.print_status).to eq("Finished")
    expect(r4.print_status).to eq("Declined")
  end
  it "returns pluralized nights" do
    expect(@reservation.nights).to eq("1 night")
    expect(@reservation2.nights).to eq("2 nights")
  end
  it "returns a reservation if user is owner or renter" do
    id = @reservation.id
    renter_id = @reservation.renter_id
    owner_id = @reservation.host.id
    renter_id2 = @reservation2.renter_id
    owner_id2 = @reservation2.host.id
    expect(Reservation.find_by_user(renter_id, id)).to eq(@reservation)
    expect(Reservation.find_by_user(owner_id, id)).to eq(@reservation)
    expect(Reservation.find_by_user(renter_id2, id)).to be_nil
    expect(Reservation.find_by_user(owner_id2, id)).to be_nil
  end
  context "#num_nights" do
    it "can calculate number of night" do
      reservation = create(:reservation, end_date: "2017-05-19")

      expect(reservation.num_nights).to eq(3)
    end
  end
end
