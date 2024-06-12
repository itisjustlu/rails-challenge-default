module Users
  module Finders
    class ByMetadata < ApplicationInteractor
      def call
        return if context.params[:metadata].blank?

        context.users = context.users.where('metadata ilike ?', "%#{context.params[:metadata]}%")
      end
    end
  end
end
