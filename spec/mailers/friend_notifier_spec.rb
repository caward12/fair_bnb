require "rails_helper"
RSpec.describe FriendNotifier, type: :mailer do
  let(:user) { user = create(:user) }
  let(:property) { create(:property) }
  let(:reservation) { create(:reservation, property: property)}
  let(:email_1) { described_class.inform(user, reservation).deliver_now  }
  let(:email_2) { described_class.inform_status(user, reservation).deliver_now  }
  let(:email_3) { described_class.inform_before(user, reservation).deliver_now  }
  
  before { ActionMailer::Base.deliveries = [] }

  it "should send reservation emails" do
    FriendNotifier.inform(user, reservation).deliver
    expect(ActionMailer::Base.deliveries).to_not be_empty
  end

  it 'renders the email_1 subject' do
    expect(email_1.subject).to eq("Fair-bnb reservation.")
  end

  it 'renders the receiver email_1' do
    expect(email_1.to).to eq([user.email])
  end

  it 'renders the sender email_1' do
      expect(email_1.from).to eq(['no-reply@fair-bnb.io'])
  end

  it 'assigns @name' do
    expect(email_1.body.encoded).to match(user.first_name)
  end

  it "should send reservation email" do
    FriendNotifier.inform_status(user, reservation).deliver
    expect(ActionMailer::Base.deliveries).to_not be_empty
  end

  it 'renders the email_2 subject' do
      expect(email_2.subject).to eq("Your Fair-bnb reservation is #{reservation.status}")
  end

  it 'renders the receiver email_2' do
    expect(email_2.to).to eq([user.email])
  end

  it 'renders the sender email_2' do
      expect(email_2.from).to eq(['no-reply@fair-bnb.io'])
  end

  it 'assigns @name' do
    expect(email_2.body.encoded).to match(user.first_name)
  end


  # it "should send reservation emails" do
  #   FriendNotifier.inform_status(user, reservation).deliver
  #   expect(ActionMailer::Base.deliveries).to_not be_empty
  # end

  it 'renders the subject' do
    expect(email_3.subject).to eq("Your Fair-bnb reservation starts in 24 hours.")
  end
  
  it 'renders the receiver email_3' do
    expect(email_3.to).to eq([user.email])
  end

  it 'renders the sender email_3' do
      expect(email_3.from).to eq(['no-reply@fair-bnb.io'])
  end

  it 'assigns @name' do
    expect(email_3.body.encoded).to match(user.first_name)
  end
end