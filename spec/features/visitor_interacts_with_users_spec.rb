require 'rails_helper'

feature 'Visitor interacts with users' do
  background do
    create(:user_with_posts, posts_count: 1, username: 'test_user')
  end

  feature 'visit user profile' do
    scenario 'from main page' do
      visit root_path
      click_link 'test_user'
      expect(page).to have_text 'test_user'
    end

    scenario 'from post page' do
      visit '/posts/1'
      click_link 'test_user'
      expect(page).to have_text 'test_user'
    end
  end

  scenario 'cannot see users index' do
    visit '/users'
    expect(page).to have_text 'You need to sign in'
  end

  given(:rating_xpath) { "//li/span[@*='badge badge-light']" }

  feature 'cannot rate user', js: true do
    scenario 'positively' do
      visit '/users/test_user'
      find(:xpath, "//*[contains(@href, '/test_user/upvote')]").click
      expect(find(:xpath, rating_xpath).text).to have_text '0'
    end

    scenario 'negatively' do
      visit '/users/test_user'
      find(:xpath, "//*[contains(@href, '/test_user/downvote')]").click
      expect(find(:xpath, rating_xpath).text).to have_text '0'
    end
  end
end
