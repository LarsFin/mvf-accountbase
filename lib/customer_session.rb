# Created for customers who wish to search the base to seek debted accounts
class CustomerSession
  attr_reader :accounts

  def initialize(accounts)
    @accounts = accounts
  end
end
