require_relative 'account_session'
require_relative 'all_current_company_guid'
require_relative 'controller'
require_relative 'customer_session'
require 'json'
require 'net/http'
# App to be used as the controller by the user
class App
  attr_reader :accounts,
              :account_session_class,
              :customer_session_class,
              :company_guid

  def initialize(account_session_class,
                 customer_session_class,
                 current_company_guid)
    @accounts = []
    @account_session_class = account_session_class
    @customer_session_class = customer_session_class
    @company_guid = current_company_guid
  end

  def create_account_session(id)
    if account_base_set_when_id_found(id) == 'id found'
      @account_session_class.new(get_details_from_account(id))
    end
  end

  def create_customer_session(key)
    begin
      if get_account_base(key)
        @customer_session_class.new(accounts)
      end
    rescue JSON::ParserError
    end
  end

  def get_account_base(key)
    url = build_url(key)
    json = get_json(url)
    @accounts = parse(json)['accounts']
  end

  private

  def account_base_set_when_id_found(id)
    company_guid.each do |account_base|
      get_account_base(account_base)
      return('id found') if accounts.any? { |account| account['id'] == id }
    end
  end

  def get_details_from_account(id)
    accounts.select { |account| account['id'] == id }.pop
  end

  def build_url(key)
    "https://mvf-devtest-s3api.s3-eu-west-1.amazonaws.com/#{key}"
  end

  def get_json(url)
    uri = URI(url)
    Net::HTTP.get(uri)
  end

  def parse(response)
    JSON.parse(response)
  end
end
