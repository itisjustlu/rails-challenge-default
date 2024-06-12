module Users
  class EnqueueAccountKeysCreator < ApplicationInteractor
    def call
      ::AccountKeys::CreatorJob.perform_later(context.user.id)
    end
  end
end
