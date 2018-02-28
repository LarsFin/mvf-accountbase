# Created for customers who wish to search the base to seek debted accounts
class CustomerSession
  attr_reader :accounts

  def initialize(accounts)
    @accounts = accounts
  end

  def get_contact_information(id)
    return false unless verify_id(id)
    account = get_account(id)
    [get_detail_of_account(account, 'firstname'),
     get_detail_of_account(account, 'lastname'),
     get_detail_of_account(account, 'email'),
     get_detail_of_account(account, 'telephone')]
  end

  def overdrawn_accounts
    overdrawn_accounts = accounts.select do |account|
      account['balance'].to_f < 0
    end
    overdrawn_accounts.map do |account|
      [get_detail_of_account(account, 'id'),
       get_detail_of_account(account, 'balance')]
    end
  end

  private

  def get_account(id)
    accounts.select { |account| account['id'] == id }.pop
  end

  def get_detail_of_account(account, detail)
    account[detail]
  end

  def verify_id(id)
    accounts.any? { |account| account['id'] == id }
  end
end
