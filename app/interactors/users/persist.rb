module Users
  class Persist < ApplicationInteractor
    def call
      user = ::User.new(context.attributes)

      if user.save
        context.user = user
      else
        context.fail!(error: user.errors.full_messages.to_sentence, status: :unprocessable_entity)
      end
    end
  end
end
