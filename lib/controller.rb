# For the user to interact with the app
class Controller
  def initialize(app_class)
    app = app_class.new
  end
end
