FactoryBot.define do
  factory :analog_param do
    unit "MyString"
    upper_range_limit 1
    lower_range_limit 1
    device nil
  end
end
