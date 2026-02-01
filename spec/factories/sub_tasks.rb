FactoryBot.define do
  factory :sub_task do
    association :task
    sequence(:title) { |n| "サブタスク#{n}" }
    description { "サブタスクの説明文" }
  end
end
