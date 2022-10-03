require './refactor'
# require './app'

# def options(num)
#   case num
#   when 1
#     display_books
#   when 2
#     list_of_people
#   when 3
#     create_person
#   when 4
#     create_new_book
#   when 5
#     create_rental
#   when 6
#     rent_list_by_id
#   end
# end

# def user_input
#   puts "
#         Please choose an option by entering a number from below:\n
#         1 - List all books
#         2 - List all people
#         3 - Create a person
#         4 - Create a book
#         5 - Create a rental
#         6 - List all rentals for a given person (id)
#         7 - Exit"

#   input_num = gets.chomp.to_i
#   options(input_num)
#   if input_num == 7
#     puts '********** Thanks for using our library  ********'
#   else
#     user_input
#   end
# end

# def main
#   puts "Welcome to the School Library App!\n"
#   app = App.new
#   app.run
# end

# main

puts "Welcome to the School Library App!\n"
new_library = Startup.new

new_library.user_input
