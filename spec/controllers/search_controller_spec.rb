# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #index' do
    let!(:bookmark1) do
      create(:bookmark, url: 'http://www.test.com/whatever', title: 'Whatever', all_tags: 'tag1, tag2')
    end
    let!(:bookmark2) do
      create(:bookmark, url: 'http://www.example.com/something', title: 'Something')
    end
    let!(:bookmark3) do
      create(:bookmark, url: 'http://www.example.com/other_hing', title: 'Other thing', all_tags: 'tag1, tag-thing2')
    end

    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'searches via querystring' do
      get :index, params: { query: 'example' }
      expect(assigns(:bookmarks).count).to eq 2
    end

    it 'searches case insensitive' do
      get :index, params: { query: 'eXaMPLe' }
      expect(assigns(:bookmarks).count).to eq 2
    end

    it 'searches for tags' do
      get :index, params: { query: 'tag1' }
      expect(assigns(:bookmarks).count).to eq 2
    end
  end
end
