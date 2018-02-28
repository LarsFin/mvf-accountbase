require 'simplecov'
require 'simplecov-console'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new( [
  SimpleCov::Formatter::Console,
] )

SimpleCov.start do
  add_filter "controller.rb"
end

RSpec.configure do |config|

  config.before(:each) do
    stub_request(:get, "https://mvf-devtest-s3api.s3-eu-west-1.amazonaws.com/key1").
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: '{"accounts":[{"id":"861fc585-3313-4928-891d-c8711dfe3f8a","firstname":"Izayah","lastname":"Hayden","email":"Izaya.HAY6958@yopmail.com","telephone":"01035 837401","balance":"8,759.84"}]}', headers: {})
    stub_request(:get, "https://mvf-devtest-s3api.s3-eu-west-1.amazonaws.com/key2").
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: '{"accounts":[{"id":"testid","firstname":"test","lastname":"testln","email":"testemail","telephone":"09","balance":"-10,390.00"}]}', headers: {})
    stub_request(:get, "https://mvf-devtest-s3api.s3-eu-west-1.amazonaws.com/key3").
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: '{"accounts":[{"id":"testid2","firstname":"test2","lastname":"testln2","email":"testemail2","telephone":"test","balance":"9.00"}]}', headers: {})
    stub_request(:get, "https://mvf-devtest-s3api.s3-eu-west-1.amazonaws.com/wrench").
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: 'Not valid', headers: {})
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

end
