module AccountKeys
  class Client
    URL = ENV['ACCOUNT_KEYS_URL']

    class << self
      def call(body)
        new(body).call
      end
    end

    def initialize(body)
      @body = body
    end

    def call
      Faraday.post("#{URL}/v1/account", @body.to_json, { 'Content-Type' => 'application/json' })
    end
  end
end
