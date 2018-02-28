require_relative 'lib/app.rb'

con = Controller.new(App,
                     AccountSession,
                     CustomerSession,
                     @current_company_guid)
con.run
