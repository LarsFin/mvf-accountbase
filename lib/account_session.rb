# Used for an account holder to interact with their information
class AccountSession
  attr_reader :details

  def initialize(details)
    @details = details
  end
end
