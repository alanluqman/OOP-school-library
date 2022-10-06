require './startup'

class Main
  def start
    puts "Welcome to the School Library App!\n"
    app = Startup.new
    app.fetch
    app.user_input
  end
end

main = Main.new
main.start
