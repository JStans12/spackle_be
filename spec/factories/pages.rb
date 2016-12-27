FactoryGirl.define do

  sequence :url do |n|
    "myurl#{n}.io"
  end

  factory :page do
    url
  end
end
