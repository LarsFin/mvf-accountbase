# For the user to interact with the app
class Controller
  attr_reader :current_user

  def initialize(app_class,
                 account_session_class,
                 customer_session_class,
                 current_company_guid)
    @app = app_class.new(account_session_class,
                         customer_session_class,
                         current_company_guid)
    @current_user = nil
  end

  def run
    puts 'Welcome'
  end
end
