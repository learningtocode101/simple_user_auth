require './lib/user'

describe User do
  let!(:user) {User.create(email: 'test@test.com', password: 'Secret123')}
  it "Doesn't sign in if user doesn't exist" do
    expect(User.authenticate('dave@dave.com', user.password)).to be_nil
  end
  it "Doesn't sign in if password is incorrect" do
    expect(User.authenticate(user.email, 'Password123')).to be_nil
  end

  describe 'details are correct' do
    let!(:dave) {User.create(email: 'dave@test.com', password: 'Secret123')}
    it "Sign in if user and password are correct" do
      expect(User.authenticate('dave@test.com', 'Secret123')).to eq(dave)
    end
  end

  describe 'already signed up with email address' do
    let!(:david) {User.create(email: 'david@test.com', password: 'Secret123')}
    let!(:davide) {User.create(email: 'david@test.com', password: 'Secret1234')}
    it "Won't let same email be used twice" do
      expect(davide.valid?).to eq false 
    end
  end
end
