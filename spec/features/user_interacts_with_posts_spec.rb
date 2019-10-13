require 'rails_helper'

feature 'User interacts with posts' do
  background do
    create(:post, content: 'Own post body')
    create(:post, content: 'Foreign post body')
    sign_in User.first
  end

  feature 'visit post' do
    given(:post_text) do
      page.find(:xpath, "//div[@*='mx-2 text-justify' and not(*)]")
    end

    scenario 'own from main page' do
      visit root_path
      click_link 'Own post body'
      expect(post_text).to have_text 'Own post body'
    end

    scenario 'own from own profile' do
      visit '/users/1'
      click_link 'Own post body'
      expect(post_text).to have_text 'Own post body'
    end

    scenario 'foreign from main page' do
      visit root_path
      click_link 'Foreign post body'
      expect(post_text).to have_text 'Foreign post body'
    end

    scenario 'foreign from foreign profile' do
      visit '/users/2'
      click_link 'Foreign post body'
      expect(post_text).to have_text 'Foreign post body'
    end
  end

  given(:own_rating_xpath) do
    "//*[@*='col-1' and */*[contains(@href, '/1/up')]]/span"
  end

  given(:own_upvote_xpath) do
    "//a[contains(@href, '/posts/1/upvote')]"
  end

  given(:own_downvote_xpath) do
    "//a[contains(@href, '/posts/1/downvote')]"
  end

  feature 'positively rate own post', js: true do
    scenario 'from main page' do
      visit root_path
      find(:xpath, own_upvote_xpath).click
      sleep 0.5
      expect(find(:xpath, own_rating_xpath).text).to have_text '1'
    end

    scenario 'from post page' do
      visit '/posts/1'
      click_link '+'
      expect(page).to have_text '1'
    end

    scenario 'from own profile' do
      visit '/users/1'
      find(:xpath, own_upvote_xpath).click
      expect(find(:xpath, own_rating_xpath).text).to have_text '1'
    end
  end

  feature 'negatively rate own post', js: true do
    scenario 'from main page' do
      visit root_path
      find(:xpath, own_downvote_xpath).click
      sleep 0.5
      expect(find(:xpath, own_rating_xpath).text).to have_text '-1'
    end

    scenario 'from post page' do
      visit '/posts/1'
      click_link '-'
      expect(page).to have_text '-1'
    end

    scenario 'from own profile' do
      visit '/users/1'
      find(:xpath, own_downvote_xpath).click
      expect(find(:xpath, own_rating_xpath).text).to have_text '-1'
    end
  end

  given(:foreign_rating_xpath) do
    "//*[@*='col-1' and */*[contains(@href, '/2/up')]]/span"
  end

  given(:foreign_upvote_xpath) do
    "//a[contains(@href, '/posts/2/upvote')]"
  end

  given(:foreign_downvote_xpath) do
    "//a[contains(@href, '/posts/2/downvote')]"
  end

  feature 'positively rate foreign post', js: true do
    scenario 'from main page' do
      visit root_path
      find(:xpath, foreign_upvote_xpath).click
      expect(find(:xpath, foreign_rating_xpath).text).to have_text '1'
    end

    scenario 'from post page' do
      visit '/posts/2'
      click_link '+'
      expect(page).to have_text '1'
    end

    scenario 'from foreign profile' do
      visit '/users/2'
      find(:xpath, "//*[contains(@href, '/posts/2/upvote')]").click
      expect(find(:xpath, foreign_rating_xpath).text).to have_text '1'
    end
  end

  feature 'negatively rate foreign post', js: true do
    scenario 'from main page' do
      visit root_path
      find(:xpath, foreign_downvote_xpath).click
      expect(find(:xpath, foreign_rating_xpath).text).to have_text '-1'
    end

    scenario 'from post page' do
      visit '/posts/2'
      click_link '-'
      expect(page).to have_text '-1'
    end

    scenario 'from foreign profile' do
      visit '/users/2'
      find(:xpath, "//*[contains(@href, '/posts/2/downvote')]").click
      expect(find(:xpath, foreign_rating_xpath).text).to have_text '-1'
    end
  end
end
