# frozen_string_literal: true

FactoryBot.define do
  factory :bookmark do
    url { 'http://www.example.com/subpage' }
    title { 'Example Subpage' }
    shortening { 'EXE' }
  end
end
