require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  it 'creates parent site record, if not present' do
    create :bookmark, url: 'http://www.test.com/whatever', title: 'Whatever'
    expect(Site.count).to eq 1

    create :bookmark, url: 'http://www.example.com/something', title: 'Something'
    create :bookmark, url: 'http://www.example.com/other_hing', title: 'Other thing'
    expect(Site.count).to eq 2
  end

  it 'removes parent record, if last child' do
    bookmark1 = create :bookmark, url: 'http://www.test.com/whatever', title: 'Whatever'
    bookmark2 = create :bookmark, url: 'http://www.example.com/something', title: 'Something'
    bookmark3 = create :bookmark, url: 'http://www.example.com/other_hing', title: 'Other thing'
    expect(Site.count).to eq 2

    bookmark1.destroy
    expect(Site.count).to eq 1

    bookmark2.destroy
    expect(Site.count).to eq 1

    bookmark3.destroy
    expect(Site.count).to eq 0
  end
end
