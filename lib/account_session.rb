# Used for an account holder to interact with their information
class AccountSession
  attr_reader :details

  def initialize(details)
    @details = details
  end

  def balance
    get_detail('balance')
  end

  def information
    [get_detail("firstname"),
     get_detail("lastname"),
     get_detail("email"),
     get_detail("telephone")]
  end

  private

  def get_detail(param)
    details[param]
  end
end
