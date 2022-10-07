require './nameable'

class Person < Nameable
  def initialize(age, name, id = 'undefined', parent_permission: true)
    @id = if id == 'undefined'
            Random.rand(1..100)
          else
            id
          end
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
    super()
  end

  def add_rental(date, book)
    @rentals = Rental.new(date, self, book)
  end

  attr_reader :id, :rentals
  attr_accessor :name, :age

  def correct_name
    @name
  end

  def of_age?
    @age >= 18
  end

  private :of_age?

  def can_use_servises?
    of_age? || @parent_permission
  end
end
