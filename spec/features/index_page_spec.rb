# coding: utf-8
require 'rails_helper'

RSpec.feature 'Index page', js: true do
  scenario 'Visiting a blank index' do
    visit '/'
    expect(page).to have_content 'No bookmarks yet'
  end

  scenario 'Adding a new bookmark' do
    visit '/'
    click_on 'New'
    fill_in 'Title', with: 'Gmail'
    fill_in 'Shortening', with: 'FL'
    fill_in 'Url', with: 'http://google.com/mail'
    click_on 'Create Bookmark'

    expect(page).to have_content 'http://google.com'
    click_on 'http://google.com'

    expect(page).to have_content 'Gmail'
  end

  describe 'with three added bookmarks' do
    let!(:bookmark1) { create(:bookmark, url: 'http://www.test.com/whatever', title: 'Whatever') }
    let!(:bookmark2) { create(:bookmark, url: 'http://www.example.com/something', title: 'Something') }
    let!(:bookmark3) { create(:bookmark, url: 'http://www.example.com/other_thing', title: 'Other thing') }

    scenario 'shows sorted bookmarks' do
      visit '/'

      # all added bookmarks are present on website
      expect(page).not_to have_content 'Whatever'
      expect(page).not_to have_content 'Something'
      expect(page).not_to have_content 'Other thing'

      # accordion is collapsed, so only titles are shown
      expect(page).to have_text 'http://www.test.com'
      expect(page).to have_text 'http://www.example.com'
      expect(page).not_to have_text 'Whatever'
      expect(page).not_to have_text 'Something'
      expect(page).not_to have_text 'Other thing'

      # check first accordion, if it has correct items
      click_on 'http://www.test.com'
      expect(page).to have_text 'Whatever'
      expect(page).not_to have_text 'Something'
      expect(page).not_to have_text 'Other thing'
    end

    scenario 'search with search form' do
      visit '/'
      fill_in 'query', with: 'thing'
      click_on 'search-submit'

      expect(page).to have_content 'http://www.example.com/something'
      expect(page).to have_content 'http://www.example.com/other_thing'
    end
  end
end
