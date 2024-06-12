class UserSerializer < ApplicationSerializer
  attributes :email,
             :phone_number,
             :full_name,
             :key,
             :account_key,
             :metadata
end