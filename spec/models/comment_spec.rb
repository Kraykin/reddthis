require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'when create or update' do
    let(:post) { create(:post_with_comments) }

    it { should belong_to :user }
    it { should belong_to :post }
    it { should validate_presence_of(:content) }
    it { expect(post.comments.first.content).to match(/Comment body/) }
  end
end
