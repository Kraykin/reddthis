require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when create or update' do
    subject { User.create(username:              "Test",
                          email:                 "test@example.com",
                          password:              "1qazXSW@",
                          password_confirmation: "1qazXSW@",
                          confirmed_at:          Time.zone.now) }

    it do
      should validate_presence_of(:username)
        .with_message("is too short (minimum is 1 character)")
    end
    it do
      should validate_length_of(:username)
        .is_at_least(1).is_at_most(50)
        .with_short_message("is too short (minimum is 1 character)")
    end
    it do
      should validate_uniqueness_of(:username).case_insensitive
    end

    it do
      should validate_presence_of(:email)
    end
    it do
      should validate_uniqueness_of(:email).case_insensitive
    end

    it do
      should validate_length_of(:password)
      .is_at_least(8).is_at_most(70)
      .with_short_message("is too short (minimum is 8 characters)")
      # "must include at least one lowercase letter, one uppercase letter, and one digit"
    end
    it { should validate_confirmation_of(:password) }

    # it do
    # should validate_length_of(:password)
    #   .is_at_least(8).is_at_most(70)
    #   .on(:create)
    #   .with_long_message("is too short (minimum is 8 characters)")
    #   # "must include at least one lowercase letter, one uppercase letter, and one digit"
    # end
  end

end
