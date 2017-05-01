# coding: utf-8
require 'rails_helper'

RSpec.feature 'New bookmark page', js: true do
  scenario 'Validation fails on blank fileds' do
    visit '/bookmarks/new'
    click_on 'Create Bookmark'

    expect(page).to have_content 'There were errors. Please fix them below.'
    expect(page).to have_content 'can\'t be blank'
  end
end
