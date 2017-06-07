require 'rails_helper'

RSpec.describe Review, type: :model do
  context "review is valid with all attributes" do
    before do
      @user = create(:user)
      @property = create(:property)
    end
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:comment) }
    it { should belong_to :user }
    it { should belong_to :property }
  end

  it "is invalid without rating" do
    review = build(:review, rating: nil, comment: "Great Home!", user: @user, property: @property)
    expect(review).to_not be_valid
  end

  it "is invalid without comment" do
    review = build(:review, rating: 5, comment: nil, user: @user, property: @property)
    expect(review).to_not be_valid
  end

  it "is invalid without owner" do
    review = build(:review, rating: 5, comment: "Great Home", user: nil, property: @property)
    expect(review).to_not be_valid
  end

  it "is invalid without property" do
    review = build(:review, rating: 5, comment: "Great Home", user: @user, property: nil)
    expect(review).to_not be_valid
  end

  it "date method returns month and year" do
    review = create(:review)

    expect(review.date).to eq("June 2017")
  end

  it "json_presenter method returns correct attributes" do
    review = create(:review)

    expect(review.json_presenter).to be_a(Hash)
    expect(review.json_presenter[:rating]).to eq(1)
    expect(review.json_presenter[:comment]).to eq("MyText")
    expect(review.json_presenter[:image]).to eq("https://fillmurray.com/200/200")
    expect(review.json_presenter[:name]).to be_a(String)
    expect(review.json_presenter[:date]).to eq("June 2017")
  end
end
