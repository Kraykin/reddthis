require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'when create or update' do
    let(:user) { create(:user_with_posts) }

    it { should belong_to :user }
    it { should validate_presence_of(:content) }
    it { expect(user.posts.first.content).to match(/Post body/) }
  end
end
