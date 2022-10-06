require './app'
require 'json'

class Startup
  def initialize
    @app = App.new
  end

  def permission
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp.capitalize
    case permission
    when 'N'
      false
    when 'Y'
      true
    else
      puts 'Invalid input'
      permission?(parent_permission)
    end
  end

  def student_option
    print ' Enter student Name : '
    name = gets.chomp
    print ' Enter student Age : '
    age = gets.chomp
    print ' Enter student Classroom <number> : '
    classroom = gets.chomp
    parent_permission = permission
    @app.create_student(age.to_i, classroom.to_i, name, parent_permission)
    puts "---------  New student Added!  ----------- \n
    #{name} is #{age} years old in classroom #{classroom.to_i}"
    puts '-------------------------------- '
  end

  def teacher_option()
    print ' Enter teacher Name : '
    name = gets.chomp
    print ' Enter teacher Age : '
    age = gets.chomp
    print ' Enter teacher specialization : '
    specialization = gets.chomp
    @app.create_teacher(specialization, age.to_i, name)
    puts '---------  New Teacher Added!  -----------'
    puts "#{name} is #{age} years old, specialization is #{specialization}"
    puts '-------------------------------- '
  end

  def new_person
    print 'Which person do you want to create ? (1) for Teacher, (2) for Student : '
    input = gets.chomp
    case input.to_i
    when 1
      teacher_option
    when 2
      student_option
    else
      puts 'you entered invalid in put! Please try again:'
      create_person
    end
  end

  def new_book
    puts '------------ Creating New Book -----------'
    print ' Enter Book Title : '
    title = gets.chomp
    print ' Enter Book Author : '
    author = gets.chomp
    @app.create_new_book(title, author)
  end

  def new_rental
    puts '------------ Making a New Rental -----------'
    puts ' Select a Book from the list below by the number'
    @app.display_books
    print ' Enter book number : '
    book_number = gets.chomp
    puts 'Select a Person from the list below by the number'
    @app.list_of_people
    person_number = gets.chomp
    print ' Enter the Date e.g (2022/9/29) : '
    date = gets.chomp
    @app.create_rental(date, person_number, book_number)
  end

  def display_rental
    puts '------------ Rental list by ID -----------'
    print '\n Enter the person\'s ID : '
    id = gets.chomp
    @app.rent_list_by_id(id)
  end
# rubocop:disable Metrics/PerceivedComplexity
  def fetch
    if File.exist?('book_list.json')
      @app.fetch_books
    else
      puts "book_list.json file doesn't exist"
    end
    if File.exist?('people.json')
      @app.fetch_people
    else
      puts "people.json file doesn't exist"
    end
    if File.exist?('rentals.json')
      if File.exist?('people.json') && File.exist?('book_list.json')
        @app.fetch_rentals
      else
        puts "rentals cannot be fetched because people.json or book_list.json doesn't exist"
      end
    else
      puts "rentals.json file doesn't exist"
    end
  end
  # rubocop:disable Metrics/PerceivedComplexity

  def user_input
    puts "
        Please choose an option by entering a number from below:\n
        1 - List all books
        2 - List all people
        3 - Create a person
        4 - Create a book
        5 - Create a rental
        6 - List all rentals for a given person (id)
        7 - Exit"

    input_num = gets.chomp.to_i
    options(input_num)
    if input_num == 7
      @app.store_book
      @app.store_person
      @app.store_rentals
      puts '********** Thanks for using our library  ********'
    else
      user_input
    end
  end

  def options(num)
    case num
    when 1
      @app.display_books
    when 2
      @app.list_of_people
    when 3
      new_person
    when 4
      new_book
    when 5
      new_rental
    when 6
      display_rental
    end
  end
end
