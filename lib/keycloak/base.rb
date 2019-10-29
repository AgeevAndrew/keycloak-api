# frozen_string_literal: true

module Keycloak
  class Base
    DEFAULT_SETTINGS_FILE_PATH = 'config/keycloak.json'
    def initialize(file_path)
      settings = JSON File.read(file_path || DEFAULT_SETTINGS_FILE_PATH)
      @realm = settings['realm']
      @client_id = settings['resource']
      @secret = settings['credentials']['secret']
      @public_key = settings['realm-public-key']
      @auth_server_url = settings['auth-server-url']
    end

    def configuration
      @configuration ||= Api.get(url: "#{auth_server_url}/realms/#{realm}/.well-known/openid-configuration")
    end

    protected

    attr_reader :realm, :client_id, :secret, :public_key, :auth_server_url
  end
end
