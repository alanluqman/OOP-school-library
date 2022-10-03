require './startup'

class Main
  def Start
    puts "Welcome to the School Library App!\n"
    app = Startup.new
    app.user_input
  end
end

main = Main.new
main.Start