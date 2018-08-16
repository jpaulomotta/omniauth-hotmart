# OmniAuth Hotmart

This is the non official OmniAuth strategy for authenticating to [Hotmart](https://www.hotmart.com) on Ruby. To use it, you'll need to sign up for an OAuth2 Application ID and Secret on the Hotmart's [HotConnect Applications Page](https://atendimento.hotmart.com.br/hc/en-us/articles/215827858-How-to-integrate-my-members-area-with-Hotmart-).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-hotmart'
```

And then execute:

    $ bundle

## Usage

```ruby
use OmniAuth::Builder do
  provider :hotmart, ENV['HOTMART_KEY'], ENV['HOTMART_SECRET']
end
```

This gem is a strategy for the Ruby authentication gem `OmniAuth`. 
[More information about OmniAuth.](https://github.com/omniauth/omniauth)


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jpaulomotta/omniauth-hotmart. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Omniauth::Hotmart project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/omniauth-hotmart/blob/master/CODE_OF_CONDUCT.md).
