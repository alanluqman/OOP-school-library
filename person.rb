require './nameable'

class Person < Nameable
  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..100)
    @name = name
    @age = age
    @parent_permission = parent_permission
    super()
  end

  attr_reader :id
  attr_accessor :name, :age

  def of_age?
    @age >= 18
  end

  private :of_age?

  def can_use_servises?
    of_age? || @parent_permission
  end
end
