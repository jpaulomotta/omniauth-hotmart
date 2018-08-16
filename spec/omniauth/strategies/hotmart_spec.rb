#Heavily inspired by OmniAuth-Github spec
require 'spec_helper'

describe OmniAuth::Strategies::Hotmart do
  let(:access_token) { instance_double('AccessToken', :options => {}) }
  let(:user_info) { { id: 1, name: 'test', country: 'Brazil', email: 'test@test.com' } }
  let(:parsed_response) { { 'UserInfoResponse' => user_info } }
  let(:response) { instance_double('Response', :parsed => parsed_response) }

  let(:enterprise_site)          { 'https://some.other.site.com/api/v3' }
  let(:enterprise_authorize_url) { 'https://some.other.site.com/login/oauth/authorize' }
  let(:enterprise_token_url)     { 'https://some.other.site.com/login/oauth/access_token' }
  let(:enterprise) do
    OmniAuth::Strategies::Hotmart.new('GITHUB_KEY', 'GITHUB_SECRET',
        {
            :client_options => {
                :site => enterprise_site,
                :authorize_url => enterprise_authorize_url,
                :token_url => enterprise_token_url
            }
        }
    )
  end

  subject do
    OmniAuth::Strategies::Hotmart.new({})
  end

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context 'client options' do
    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://api.hotmart.com.br')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('/oauth/authorize')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('/oauth/access_token')
    end

  end

  context '#raw_info' do
    it 'should use relative paths' do
      expect(access_token).to receive(:post).with('/user_info').and_return(response)
      expect(subject.raw_info).to eq(user_info)
    end
  end
end