require 'simplecov'
require 'simplecov-console'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new( [
  SimpleCov::Formatter::Console,
] )

SimpleCov.start

RSpec.configure do |config|

  config.before(:each) do
    stub_request(:get, /mvf-devtest-s3api.s3-eu-west-1.amazonaws.com/).
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: '{"accounts":[{"id":"861fc585-3313-4928-891d-c8711dfe3f8a","firstname":"Izayah","lastname":"Hayden","email":"Izaya.HAY6958@yopmail.com","telephone":"01035 837401","balance":"8,759.84"}]}', headers: {})
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

end
