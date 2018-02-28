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
    account_holder?
  end

  def account_holder?
    puts 'Are you an account holder?'
  end

  def evaluate(input)
    return(false) if input[0].casecmp('n').zero?
    return(true) if input[0].casecmp('y').zero?
    quit if %w[quit exit].include?(input)
    'not-recognisable'
  end

  def quit
    puts "Thankyou,\nclosing..."
  end
end
