# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New_bookmark page', js: true, type: :feature do
  it 'Validation fails on blank fileds' do
    visit '/bookmarks/new'
    click_on 'Create Bookmark'

    expect(page).to have_content 'There were errors. Please fix them below.'
    expect(page).to have_content 'can\'t be blank'
  end
end
