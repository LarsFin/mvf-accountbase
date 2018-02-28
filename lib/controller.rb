# For the user to interact with the app
class Controller
  def initialize(app_class,
                 account_session_class,
                 customer_session_class,
                 current_company_guid)
    @app = app_class.new
  end
end
