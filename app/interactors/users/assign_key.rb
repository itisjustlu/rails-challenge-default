module Users
  class AssignKey < ApplicationInteractor
    def call
      context.attributes = context.attributes.merge(key: SecureRandom.hex(16))
    end
  end
end
