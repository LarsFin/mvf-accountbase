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
    input = evaluate(gets.chomp)
    if input == 'not-recognisable'
      account_holder?
    else
      input ? enter_account_holder_id : customer?
    end
  end

  def customer?
    puts 'Are you a customer?'
  end

  def enter_account_holder_id
    puts 'Please enter your id'
    if @current_user = @app.create_account_session(gets.chomp)
      puts "Hello #{@current_user.details['firstname']}!"
      list_account_holder_actions
    else
      puts 'couldnt find'
    end
  end

  def list_account_holder_actions
    puts 'Type the respective character for your choice'
    puts '1. View Info'
    puts '2. View Balance'
    puts '3. Logout'
    puts 'q. Quit'
    account_holder_choice
  end

  def account_holder_choice
    case gets.chomp
    when '1'
      pretty_print_details(@current_user.information)
    when '2'
      puts "\n"
      puts "£#{@current_user.balance}"
      puts "\n"
    when '3'
      @current_user = nil
      account_holder?
    when 'q'
      quit
    else
      puts 'Unrecognisable input, please try again'
    end
    list_account_holder_actions
  end

  def pretty_print_details(details)
    puts "\n"
    puts "First name:   |   #{details[0]}"
    puts "Last name:    |   #{details[1]}"
    puts "Email:        |   #{details[2]}"
    puts "Telephone:    |   #{details[3]}"
    puts "\n"
  end

  def evaluate(input)
    return(false) if input[0].casecmp('n').zero?
    return(true) if input[0].casecmp('y').zero?
    quit if %w[quit exit].include?(input)
    puts 'Unrecognisable input, please try again'
    'not-recognisable'
  end

  def quit
    puts "Thankyou,\nclosing..."
    exit
  end
end
