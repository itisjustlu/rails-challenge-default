module Users
  class Creator < ApplicationInteractor
    organize ::Users::AssignKey,
             ::Users::Persist,
             ::Users::EnqueueAccountKeysCreator
  end
end