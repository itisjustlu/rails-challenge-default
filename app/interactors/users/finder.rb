module Users
  class Finder < ApplicationInteractor
    before do
      context.users = User.all
    end

    organize ::Users::Finders::ValidateParams,
             ::Users::Finders::ByEmail,
             ::Users::Finders::ByFullName,
             ::Users::Finders::ByMetadata
  end
end