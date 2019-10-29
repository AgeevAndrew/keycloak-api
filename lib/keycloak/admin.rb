# frozen_string_literal: true

require_relative 'api'
require_relative 'base'

module Keycloak
  class Admin < Base
    def initialize(file_path = nil)
      super(file_path)

      get_token_by_client_credentials
    end

    private

    attr_reader :token_info

    def get_token_by_client_credentials
      payload = { client_id: client_id,
                  client_secret: secret,
                  grant_type: 'client_credentials' }

      @token_info = Api.post(url: configuration[:token_endpoint], json: false, **payload)
    end
  end
end
