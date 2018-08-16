require 'omniauth-oauth2'
require 'omniauth-hotmart/access_token_middleware'

module OmniAuth
  module Strategies
    class Hotmart < OmniAuth::Strategies::OAuth2
      #include OmniAuth::Strategy

      # Give your strategy a name.
      option :name, "hotmart"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {:site => "https://api.hotmart.com.br",
        :authorize_url => '/oauth/authorize',
        :token_url => '/oauth/access_token',
        
        #Faraday middleware (passed from OAuth2 gem to Faraday)
        :connection_build => Proc.new {|con|
          con.request  :url_encoded             # form-encode POST params
          con.use AccessTokenMiddleware
          con.adapter Faraday.default_adapter  # make requests with Net::HTTP
        }, 
      }

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['id'] }

      info do
        {
          :name => raw_info['name'],
          :email => raw_info['email'],
          :country => raw_info['country']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        access_token.options[:mode] = :body
        access_token.options[:param_name] = :access_token 
        @raw_info ||= access_token.post('/user_info').parsed['UserInfoResponse']
      end
    end
  end
end