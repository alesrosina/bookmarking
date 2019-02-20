# frozen_string_literal: true

FactoryBot.define do
  factory :site do
    url { 'http://www.example.com' }
    title { 'Example' }
  end
end
