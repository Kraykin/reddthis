require 'rails_helper'

feature 'Visitor interacts with posts' do
  background do
    create(:post, content: 'Post body')
  end

  feature 'visit post' do
    given(:post_text) do
      page.find(:xpath, "//div[@*='mx-2 text-justify' and not(*)]")
    end

    scenario 'from main page' do
      visit root_path
      click_link 'Post body'
      expect(post_text).to have_text 'Post body'
    end

    scenario 'from user profile' do
      visit '/users/1'
      click_link 'Post body'
      expect(post_text).to have_text 'Post body'
    end
  end

  scenario 'cannot create post' do
    visit '/posts/new'
    expect(page).to have_text 'You need to sign in'
  end

  given(:rating_xpath) do
    "//*[@*='col-1' and */*[contains(@href, '/1/up')]]/span"
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
      expect(find(:xpath, rating_xpath).text).to have_text '0'
    end
  end
end
