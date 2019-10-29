# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

require 'awrence'
require 'plissken'

module Keycloak
  class Api
    class << self
      def post(url:, json: true, **params)
        request = Net::HTTP::Post.new(URI(url))
        request['Content-Type'] = json ? 'application/json' : 'application/x-www-form-urlencoded'
        request.body = json ? params.to_json : URI.encode_www_form(params)

        parse request, params
      end

      def get(url:, json: true, **params)
        uri = URI(url)
        uri.query = URI.encode_www_form(params.to_camelback_keys)
        request = Net::HTTP::Get.new(uri)
        request['Content-Type'] = json ? 'application/json' : 'application/x-www-form-urlencoded'
        parse request, params
      end

      private

      def parse(request, params)
        response = call(request)

        puts response.body

        return JSON.parse(response.body || '{}', symbolize_names: true).to_snake_keys if response.is_a? Net::HTTPSuccess

        raise ResponseError.new(
          code: response.code,
          message: response.body.to_s,
          http_params: params,
          http_request: request,
        )
      end

      def call(request)
        Net::HTTP.start(request.uri.hostname, request.uri.port) do |http|
          http.request request
        end
      end
    end
  end
end
