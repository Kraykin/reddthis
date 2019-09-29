require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when create or update' do
    it do
      should validate_presence_of(:username)
        .with_message("is too short (minimum is 1 character)")
    end
    it do
      should validate_length_of(:username)
        .is_at_least(1).is_at_most(50)
        .with_short_message("is too short (minimum is 1 character)")
    end

    it { should validate_presence_of(:email) }

    context 'with validate uniqueness' do
      let!(:user) { create(:user) }

      it do
        should validate_uniqueness_of(:username).case_insensitive
      end

      it do
        should validate_uniqueness_of(:email).case_insensitive
      end
    end

    it do
      should validate_length_of(:password)
        .is_at_least(8).is_at_most(70)
        .with_short_message("is too short (minimum is 8 characters)")
    end

    it { should validate_confirmation_of(:password) }

    it do
      should_not allow_values("12345678").for(:password)
        .with_message(/one lowercase.+one uppercase.+one digit/)
    end

    it { should have_many :posts }

    it do
      should define_enum_for(:role)
        .with_values([:user, :moderator, :admin])
    end
  end
end
