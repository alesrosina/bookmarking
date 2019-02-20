# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'loads all of the bookmarks grouped in sites' do
      create :bookmark, url: 'http://www.test.com/whatever', title: 'Whatever'
      create :bookmark, url: 'http://www.example.com/something', title: 'Something'
      create :bookmark, url: 'http://www.example.com/other_hing', title: 'Other thing'

      get :index
      expect(assigns(:sites).count).to eq 2
    end
  end

  describe 'POST #create' do
    it 'redirects to the home page after save' do
      post :create, params: { bookmark: attributes_for(:bookmark) }
      expect(response).to redirect_to bookmarks_path
    end
  end

  describe 'PATCH #update' do
    let(:bookmark1) { create(:bookmark) }

    it 'updates one value' do
      put :update, params: { id: bookmark1.id, bookmark: attributes_for(:bookmark, title: 'new title') }
      bookmark1.reload
      expect(bookmark1.title).to eq 'new title'
    end

    it 'redirects to the home page after update' do
      put :update, params: { id: bookmark1.id, bookmark: attributes_for(:bookmark) }
      expect(response).to redirect_to bookmarks_path
    end
  end

  describe 'DELETE #delete' do
    let!(:bookmark1) { create(:bookmark) }

    it 'deletes the bookmark' do
      expect(Bookmark.count).to eq 1
      delete :destroy, params: { id: bookmark1.id }
      expect(Bookmark.count).to eq 0
    end

    it 'redirects to the home page after delte' do
      delete :destroy, params: { id: bookmark1.id }
      expect(response).to redirect_to bookmarks_path
    end
  end
end
