FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "タスク#{n}" }
    description { "タスクの説明文" }
    sequence(:position) { |n| n }
  end
end
