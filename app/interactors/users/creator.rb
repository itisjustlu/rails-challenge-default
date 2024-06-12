module Users
  class Creator < ApplicationInteractor
    organize ::Users::AssignKey,
             ::Users::Persist
  end
end