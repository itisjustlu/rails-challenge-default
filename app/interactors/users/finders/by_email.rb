module Users
  module Finders
    class ByEmail < ApplicationInteractor
      def call
        return if context.params[:email].blank?

        context.users = context.users.where('email ilike ?', "%#{context.params[:email]}%")
      end
    end
  end
end
