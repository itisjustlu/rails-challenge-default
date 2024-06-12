module Users
  module Finders
    class ValidateParams < ApplicationInteractor
      VALID_KEYS = %i(email full_name metadata)

      def call
        return if valid?

        context.fail!(errors: 'Invalid query params', status: :unprocessable_entity)
      end

      private

      def valid?
        context.params.keys.map(&:to_sym) - VALID_KEYS == []
      end
    end
  end
end
