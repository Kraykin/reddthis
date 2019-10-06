require 'rails_helper'

feature 'Visitor interacts with posts' do
  background do
    create(:post, content: 'Post body')
  end

  feature 'visit post' do
    scenario 'from main page' do
      visit root_path
      visit find_link('Post body')[:href]
      expect(page).to have_text 'Post body'
    end

    scenario 'from user profile' do
      visit '/users/1'
      visit find_link('Post body')[:href]
      expect(page).to have_text 'Post body'
    end
  end

  scenario 'cannot create post' do
    visit '/posts/new'
    expect(page).to have_text 'You need to sign in'
  end

  feature 'cannot positively rate post', js: true do
    scenario 'from main page' do
      visit root_path
      click_link '+'
      expect(page).to have_text '0'
    end

    scenario 'from post page' do
      visit '/posts/1'
      click_link '+'
      expect(page).to have_text '0'
    end

    scenario 'from user profile' do
      visit '/users/1'
      find(:xpath, "//*[contains(@href, '/posts/1/upvote')]").click
      rating_xpath = "//*[@*='col-1' and */*[contains(@href, '/1/up')]]/span"
      expect(find(:xpath, rating_xpath).text).to have_text '0'
    end
  end

  feature 'cannot negatively rate post', js: true do
    scenario 'from main page' do
      visit root_path
      click_link '-'
      expect(page).to have_text '0'
    end

    scenario 'from post page' do
      visit '/posts/1'
      click_link '-'
      expect(page).to have_text '0'
    end

    scenario 'from user profile' do
      visit '/users/1'
      find(:xpath, "//*[contains(@href, '/posts/1/downvote')]").click
      rating_xpath = "//*[@*='col-1' and */*[contains(@href, '/1/down')]]/span"
      expect(find(:xpath, rating_xpath).text).to have_text '0'
    end
  end
end
