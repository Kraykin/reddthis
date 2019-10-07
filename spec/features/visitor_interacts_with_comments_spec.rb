require 'rails_helper'

feature 'Visitor interacts with comments' do
  background do
    create(:comment, content: 'Comment body')
  end

  feature 'sees comment' do
    scenario 'from post page' do
      visit '/posts/1'
      expect(page).to have_text 'Comment body'
    end

    scenario 'from user profile', js: true do
      visit '/users/1'
      find_link('Comments').click
      expect(page).to have_text 'Comment body'
    end
  end

  scenario 'cannot create comment' do
    visit '/posts/1'
    expect(page).not_to have_button 'Create Comment'
  end

  given(:rating_xpath) { "//*[@*='col-1' and */*[contains(@href, '/1/up')]]/span" }

  feature 'cannot positively rate comment', js: true do
    scenario 'from post page' do
      visit '/posts/1'
      find(:xpath, "//*[contains(@href, '/comments/1/upvote')]").click
      expect(find(:xpath, rating_xpath).text).to have_text '0'
    end

    scenario 'from user profile' do
      visit '/users/1'
      find_link('Comments').click
      find(:xpath, "//*[contains(@href, '/comments/1/upvote')]").click
      expect(find(:xpath, rating_xpath).text).to have_text '0'
    end
  end

  feature 'cannot negatively rate comment', js: true do
    scenario 'from post page' do
      visit '/posts/1'
      find(:xpath, "//*[contains(@href, '/comments/1/downvote')]").click
      expect(find(:xpath, rating_xpath).text).to have_text '0'
    end

    scenario 'from user profile' do
      visit '/users/1'
      find_link('Comments').click
      find(:xpath, "//*[contains(@href, '/comments/1/downvote')]").click
      expect(find(:xpath, rating_xpath).text).to have_text '0'
    end
  end
end
