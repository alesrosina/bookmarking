require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'searches via querystring' do
      create(:bookmark, url: 'http://www.test.com/whatever', title: 'Whatever')
      create(:bookmark, url: 'http://www.example.com/something', title: 'Something')
      create(:bookmark, url: 'http://www.example.com/other_hing', title: 'Other thing')

      get :index, params: { query: 'example' }
      expect(assigns(:bookmarks).count).to eq 2
    end
  end
end