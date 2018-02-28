# App to be used as the controller by the user
class App
  attr_reader :accounts

  def initialize
    @accounts = []
  end
end
