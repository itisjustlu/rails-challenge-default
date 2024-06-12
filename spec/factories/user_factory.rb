FactoryBot.define do
  factory :user do
    email { "#{SecureRandom.uuid}@firstleaft.com" }
    phone_number { "+#{SecureRandom.hex(4)}" }
    full_name { "John Doe" }
    password { "password" }
    password_confirmation { "password" }
    key { SecureRandom.uuid }
    account_key { SecureRandom.uuid }
    metadata { "metadata" }
  end
end