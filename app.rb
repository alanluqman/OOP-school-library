require './book'
require './person'
require './rental'
require './student'
require './teacher'
require './classroom'

class App
  def initialize
    @book_list = []
    @people = []
    @students = []
    @teachers = []
    @rentals = []
  end

  attr_accessor :book_list, :people

  def run
    user_input
  end

  def display_books
    puts '----  List of All Books -----'
    if @book_list.empty?
      puts 'Book store is Empty !'
    else
      @book_list.each_with_index do |book, index|
        puts "#{index + 1} - #{book.title} by #{book.author}"
      end
    end
    puts '-----------------------------'
  end

  def list_of_people
    puts '----  List of All People -----'
    if @people.empty?
      puts 'No People Registered !'
    else
      @people.each_with_index do |person, index|
        if person.instance_of?(Student)
          puts "#{index + 1} -  [Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
        else
          puts "#{index + 1} - [Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
        end
      end
    end
    puts '-----------------------------'
  end

  def create_person
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

  def permission?(parent_permission)
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp
    case permission
    when 'n', 'N'
      !parent_permission
    when 'y', 'Y'
      parent_permission
    else
      permission?(parent_permission)
    end
  end

  def create_student(age, classroom, name, parent_permission)
    student = Student.new(age, classroom, name, parent_permission: parent_permission)
    @people << student unless @people.include?(student)
    @students << student unless @students.include?(student)
  end

  def create_teacher(specialization, age, name)
    teacher = Teacher.new(specialization, age, name)
    @people << teacher unless @people.include?(teacher)
    @teachers << teacher unless @teachers.include?(teacher)
  end

  def student_option
    print ' Enter student Name : '
    name = gets.chomp
    print ' Enter student Age : '
    age = gets.chomp
    print ' Enter student Classroom <number> : '
    classroom = gets.chomp
    parent_permission = true
    permission?(parent_permission)
    create_student(age.to_i, classroom.to_i, name, parent_permission)
    puts "---------  New student Added!  ----------- \n
    #{name} is #{age} years old in classroom #{classroom.to_i}"
    puts '-------------------------------- '
  end

  def teacher_option
    print ' Enter teacher Name : '
    name = gets.chomp
    print ' Enter teacher Age : '
    age = gets.chomp
    print ' Enter teacher specialization : '
    specialization = gets.chomp
    create_teacher(specialization, age.to_i, name)
    puts '---------  New Teacher Added!  -----------'
    puts "#{name} is #{age} years old, specialization is #{specialization}"
    puts '-------------------------------- '
  end

  def create_new_book
    puts '------------ Creating New Book -----------'
    print ' Enter Book Title : '
    title = gets.chomp
    print ' Enter Book Author : '
    author = gets.chomp

    book = Book.new(title, author)
    @book_list << book unless @book_list.include?(book)
    puts '------------ New Book Added -----------'
    puts "#{title} by #{author} added to book list successfuly!\n
    -----------------------------------"
  end

  def create_rental
    puts '------------ Making a New Rental -----------'
    puts ' Select a Book from the list below by the number'
    display_books
    print ' Enter book number : '
    book_number = gets.chomp
    puts 'Select a Person from the list below by the number'
    list_of_people
    person_number = gets.chomp
    print ' Enter the Date e.g (2022/9/29) : '
    date = gets.chomp

    rent = Rental.new(date, people[person_number.to_i - 1], book_list[book_number.to_i - 1])
    @rentals << rent unless @rentals.include?(rent)
    puts '-------- Rental Created -------'
    puts '-----------------------------'
  end

  def rent_list_by_id
    puts '------------ Rental list by ID -----------'
    print '\n Enter the person\'s ID : '
    id = gets.chomp
    puts '**** Rental list ****'
    if @rentals.empty?
      puts 'No rental recorded !'
    else
      @rentals.select do |rent|
        if rent.person.id == id.to_i
          puts "Date: #{rent.date}, Book '#{rent.book.title}' by #{rent.book.author}"
        else
          puts "#{rent.person.name} does not reantal a book!"
        end
      end
    end
    puts '-----------------------------'
  end
end
