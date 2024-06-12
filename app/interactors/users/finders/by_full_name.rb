module Users
  module Finders
    class ByFullName < ApplicationInteractor
      def call
        return if context.params[:full_name].blank?

        context.users = context.users.where('full_name ilike ?', "%#{context.params[:full_name]}%")
      end
    end
  end
end
