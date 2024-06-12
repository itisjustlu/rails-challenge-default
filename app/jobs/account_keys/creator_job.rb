module AccountKeys
  class CreatorJob < ApplicationJob
    queue_as :default

    sidekiq_options retry: 5

    def perform(user_id)
      user = User.find(user_id)

      result = AccountKeys::Client.call(user_id: user.id, email: user.email)

      if result.success?
        json = JSON.parse(result.body)
        user.update(account_key: json['account_key'])
      else
        raise "Error creating account key for user #{user.id}"
      end
    end
  end
end
