FactoryGirl.define do
  factory :url do
    status_id 1
    sequence(:url) do |n|
      "http://www.google.com?s=#{n}"
    end
    visited_at Date.new(2000, 1, 1)
  end

  factory :site do
    sequence(:code) do |n|
      "site#{n}"
    end
    sequence(:domain) do |n|
      "www.site#{n}.com"
    end
    campaign_id 'cid'
  end
end