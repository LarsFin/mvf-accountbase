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

  def evaluate(input)
    return(false) if input[0].casecmp('n').zero?
    return(true) if input[0].casecmp('y').zero?
    quit if %w[quit exit].include?(input)
    puts 'Unrecognisable input, please try again'
    'not-recognisable'
  end

  def run
    puts 'Welcome'
    account_holder?
  end

  private

  def account_holder?
    puts 'Are you an account holder? (type quit or exit to close)'
    result = evaluate(gets.chomp)
    if result == 'not-recognisable'
      account_holder?
    else
      result ? enter_account_holder_id : customer?
    end
  end

  def customer?
    puts 'Are you a customer? (type quit or exit to close)'
    result = evaluate(gets.chomp)
    if result == 'not-recognisable'
      account_holder?
    else
      result ? enter_company_id : account_holder?
    end
  end

  def enter_company_id
    puts 'Please enter your company\'s guid'
    if @current_user = @app.create_customer_session(gets.chomp + '.json')
      puts "Hello"
      list_customer_actions
    else
      puts 'couldnt find that company guid'
      customer?
    end
  end

  def enter_account_holder_id
    puts 'Please enter your guid'
    if @current_user = @app.create_account_session(gets.chomp)
      puts "Hello #{@current_user.details['firstname']}!"
      list_account_holder_actions
    else
      puts 'couldnt find that guid'
      account_holder?
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

  def list_customer_actions
    puts 'Type the respective character for your choice'
    puts '1. View overdrawn accounts'
    puts '2. Search account holder'
    puts '3. Logout'
    puts 'q. Quit'
    customer_choice
  end

  def customer_choice
    case gets.chomp
    when '1'
      display_overdrawn_accounts
    when '2'
      search_account_holder
    when '3'
      logout
    when 'q'
      quit
    else
      puts 'Unrecognisable input, please try again'
    end
    list_customer_actions
  end

  def display_overdrawn_accounts
    puts '\n'
    @current_user.overdrawn_accounts.each { |overdrawn_account|
      puts "     id    |    #{overdrawn_account[0]}"
      puts "balance    |    £#{overdrawn_account[1]}"
      puts "\n"
    }
    puts '\n'
  end

  def search_account_holder
    puts "Please enter account holder's id"
    if info = @current_user.get_contact_information(gets.chomp)
      pretty_print_details(info)
    else
      puts 'Couldn\'t find an account holder with that id'
      puts "\n"
    end
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
      logout
    when 'q'
      quit
    else
      puts 'Unrecognisable input, please try again'
    end
    list_account_holder_actions
  end

  def logout
    @current_user = nil
    account_holder?
  end

  def pretty_print_details(details)
    puts "\n"
    puts "First name:   |   #{details[0]}"
    puts "Last name:    |   #{details[1]}"
    puts "Email:        |   #{details[2]}"
    puts "Telephone:    |   #{details[3]}"
    puts "\n"
  end

  def quit
    puts "Thankyou,\nclosing..."
    exit
  end
end
