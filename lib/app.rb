require_relative 'account_session'
require_relative 'customer_session'
require 'json'
require 'net/http'
# App to be used as the controller by the user
class App
  attr_reader :accounts, :account_session_class, :customer_session_class

  def initialize(account_session_class, customer_session_class)
    file = File.read('a4a06bb0-3fbe-40bd-9db2-f68354ba742f.json')
    @accounts = JSON.parse(file)['accounts']
    @account_session_class = account_session_class
    @customer_session_class = customer_session_class
  end

  def create_account_session(id)
    @account_session_class.new(get_details(id)) if verify_id(id)
  end

  def create_customer_session
    @customer_session_class.new(accounts)
  end

  def get_account_base(key)
    url = build_url(key)
    json = get_JSON(url)
    parse(json)
  end

  private

  def verify_id(id)
    accounts.any? { |account| account['id'] == id }
  end

  def get_details(id)
    accounts.select { |account| account['id'] == id }.pop
  end

  def build_url(key)
    "https://mvf-devtest-s3api.s3-eu-west-1.amazonaws.com/#{key}"
  end

  def get_JSON(url)
    uri = URI(url)
    Net::HTTP.get(uri)
  end

  def parse(response)
    JSON.parse(response)
  end
end
