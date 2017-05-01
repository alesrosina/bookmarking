FactoryGirl.define do
  factory :bookmark do
    url 'http://www.example.com/subpage'
    title  'Example Subpage'
    shortening 'EXE'
    association :site, factory: :site, url: 'http://www.example.com'
  end
end
