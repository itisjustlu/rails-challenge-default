module Users
  class Persist < ApplicationInteractor
    def call
      user = ::User.new(context.attributes)

      if user.save
        context.user = user
      else
        context.fail!(errors: user.errors.full_messages, status: :unprocessable_entity)
      end
    end
  end
end
