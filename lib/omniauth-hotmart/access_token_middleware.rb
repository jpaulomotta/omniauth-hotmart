require 'json'

module OmniAuth
  module Hotmart
    class AccessTokenMiddleware

      attr_reader :options

      def initialize(app, options={})
        @app = app
        @options = options
      end

      def call(request_env)
        if request_env.url.path == "/oauth/access_token"
          @app.call(request_env).on_complete do |response_env| 
            response_env.body = JSON.generate(JSON.parse(response_env.body)["TokenResponse"])
          end
        else
          @app.call(request_env)
        end
      end
      
    end
  end
end