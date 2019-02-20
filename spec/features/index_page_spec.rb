# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Index page', js: true, type: :feature do # rubocop:disable Metrics/BlockLength
  it 'Visiting a blank index' do
    visit '/'
    expect(page).to have_content 'No bookmarks yet'
  end

  it 'Adding a new bookmark' do
    visit '/'
    click_on 'New'
    fill_in 'Title', with: 'Gmail'
    fill_in 'Shortening', with: 'FL'
    fill_in 'Url', with: 'http://google.com/mail'
    fill_in 'All tags', with: 'tag1, tag2, test-tag'
    click_on 'Create Bookmark'

    expect(page).to have_content 'http://google.com'
    click_on 'http://google.com'

    expect(page).to have_content 'Gmail'
    expect(page).to have_content 'tag1'
    expect(page).to have_content 'tag2'
    expect(page).to have_content 'test-tag'

    expect(Tag.count).to eq 3
  end

  describe 'with three added bookmarks' do
    let!(:bookmark1) do
      create(
        :bookmark,
        url: 'http://www.test.com/whatever',
        title: 'Whatever',
        all_tags: 'testTag, whateverTag'
      )
    end
    let!(:bookmark2) do
      create(
        :bookmark,
        url: 'http://www.example.com/something',
        title: 'Something',
        all_tags: 'testTag'
      )
    end
    let!(:bookmark3) { create(:bookmark, url: 'http://www.example.com/other_thing', title: 'Other thing') }
    let!(:tag1) { create(:tag, name: 'hiddenTag') }

    it 'shows sorted bookmarks with tags' do
      visit '/'

      expect(page).to have_text 'http://www.test.com'
      expect(page).to have_text 'http://www.example.com'
      # only first accordion is shown
      expect(page).to have_text 'Whatever'
      expect(page).to have_text 'testTag'
      expect(page).to have_text 'whateverTag'
      expect(page).not_to have_text 'Something'
      expect(page).not_to have_text 'Other thing'

      # open second accordion, which closes first one
      click_on 'http://www.example.com'
      expect(page).not_to have_text 'Whatever'
      expect(page).to have_text 'Something'
      expect(page).to have_text 'Other thing'
      expect(page).to have_text 'testTag'
      expect(page).not_to have_text 'whateverTag'
    end

    it 'shows only used tags in navbar' do
      visit '/'
      find('a', text: 'Filter by Tag').click

      expect(page).to have_text 'testTag'
      expect(page).to have_text 'whateverTag'
      expect(page).not_to have_text 'hiddenTag'
    end

    it 'search with search form' do
      visit '/'
      fill_in 'query', with: 'thing'
      click_on 'search-submit'

      expect(page).to have_content 'http://www.example.com/something'
      expect(page).to have_content 'http://www.example.com/other_thing'
    end
  end
end
