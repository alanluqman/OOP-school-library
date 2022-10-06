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

          puts "#{index + 1} -  #{[person.class]} Name: #{person.name},
          ID: #{person.id}, Age: #{person.age}, Permission: #{person.parent_permission}"

        else

          puts "#{index + 1} - #{[person.class]} Name: #{person.name},
          ID: #{person.id}, Age: #{person.age} , specialization : #{person.specialization}"

        end
      end

    end

    puts "\n-----------------------------------------"
  end

  def create_student(age, classroom, name, parent_permission)
    id = Random.rand(1..100)
    student = Student.new(age, classroom, name, parent_permission, id)

    @people << student unless @people.include?(student)

    @students << student unless @students.include?(student)
  end

  def create_teacher(specialization, age, name)
    id = Random.rand(1..100)
    teacher = Teacher.new(specialization, age, name, id)

    @people << teacher unless @people.include?(teacher)

    @teachers << teacher unless @teachers.include?(teacher)
  end

  def create_new_book(title, author)
    book = Book.new(title, author)

    @book_list << book unless @book_list.include?(book)

    puts '------------ New Book Added -----------'

    puts "#{title} by #{author} added to book list successfuly!\n



    -----------------------------------"
  end

  def create_rental(date, person_number, book_number)
    rent = Rental.new(date, people[person_number.to_i - 1], book_list[book_number.to_i - 1])
    @rentals << rent unless @rentals.include?(rent)

    puts '-------- Rental Created -------'

    puts '-----------------------------'
  end

  def rent_list_by_id(id)
    puts '**** Rental list ****'

    if @rentals.empty?

      puts 'No rental recorded !'

    else

      @rentals.select do |rent|
        puts "Date: #{rent.date}, Book '#{rent.book.title}' by #{rent.book.author}" if rent.person.id == id.to_i
      end

    end

    puts '-----------------------------'
  end

  def store_book
    books = []

    @book_list.each { |book| books.push({ title: book.title, author: book.author }) }

    data = JSON.generate(books)

    File.write('book_list.json', data)
  end

  def fetch_books
    data = JSON.parse(File.read('book_list.json'))
    data.each { |book| @book_list << Book.new(book['title'], book['author']) }
  end

  def store_rentals
    store = []
    @rentals.each { |rent| store.push({ date: rent.date, person: rent.person.name, book: rent.book.title }) }
    data = JSON.generate(store)
    File.write('rentals.json', data)
  end

  def fetch_rentals
    data = JSON.parse(File.read('rentals.json'))
    if data == []
      puts 'rental storage is empty'
    else
      fetch_objects(data)
    end
  end

  def fetch_objects(data)
    data.each do |rent|
      p_index = nil
      @people.each_with_index do |person, index|
        p_index = index if person.name == rent['person']
      end
      b_index = nil
      @book_list.each_with_index do |book, index|
        b_index = index if book.title == rent['book']
      end
      if p_index && b_index
        new_rent = Rental.new(rent['date'], people[p_index], book_list[b_index])
        @rentals << new_rent unless @rentals.include?(new_rent)
      end

    end
  end

  def store_person
    persons = []
    @people.each do |person|
      if person.instance_of?(Teacher)
        persons.push({ character: person.class,
                       id: person.id,
                       name: person.name,
                       age: person.age,
                       specialization: person.specialization })
      else
        persons.push({ character: person.class,
                       id: person.id,
                       name: person.name,
                       age: person.age,
                       classroom: person.classroom,
                       parent_permission: person.parent_permission })
      end
    end
    File.write('people.json', JSON.generate(persons))
  end

  def fetch_people
    data = JSON.parse(File.read('people.json'))
    data.each do |person|
      @people << if person['character'] == 'Teacher'
                   Teacher.new(person['specialization'], person['age'], person['name'], person['id'])
                 else
                   Student.new(person['age'], person['classroom'], person['name'], person['parent_permission'],
                               person['id'])
                 end
    end
  end
end
