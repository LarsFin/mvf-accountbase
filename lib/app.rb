require 'json'
# App to be used as the controller by the user
class App
  attr_reader :accounts

  def initialize
    @accounts = JSON.parse(File.read('a4a06bb0-3fbe-40bd-9db2-f68354ba742f.json'))["accounts"]
  end
end
