# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
  before { @user = User.new(:name => 'PD', :email => 'something@gmail.com',
                           :password=>"random", :password_confirmation=>"random") }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:name) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should  be_valid }


  describe "when password is too short" do
    before { @user.password  = @user.password_confirmation = "a"*5 }
    it { should_not be_valid } 
  end

  describe "return value of authenticate" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end
    describe "with invalid passwords" do
      let(:user_with_invalid_password) { found_user.authenticate("invalid") } 

      it { should_not == user_with_invalid_password }
      specify { user_with_invalid_password.should be_false }
    end
  end

  describe "when password is blank" do
    before {@user.password  = @user.password_confirmation = "  " }
    it { should_not be_valid }
  end

  describe "when passwords don't match" do
    before { @user.password_confirmation="foobar" }
    it { should_not be_valid }
  end
  describe "when name is not present" do 
    before { @user.name = "" }
    it { should_not be_valid }
  end
  describe "when email is not present" do 
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email is already taken" do
    before do
      another_user = @user.dup;
      another_user.email = @user.email.upcase;
      another_user.save
    end
    it { should_not be_valid }
  end
end

