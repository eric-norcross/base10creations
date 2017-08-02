# models/figure.rb

FactoryGirl.define do
  factory :figure, class: Figure do
    transient do
      figureable    Page.new
      image         Rack::Test::UploadedFile.new(
                      File.join(
                        Rails.root, 'spec', 'assets', 'images', 'test_image_1.jpg'
                      ),'image/jpg'
                    )
    end

    after :build do |figure, evaluator|
      figure.figureable = evaluator.figureable
      figure.image      = evaluator.image
    end
  end
end