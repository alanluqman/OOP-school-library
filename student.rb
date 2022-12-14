require './person'
class Student < Person
  attr_reader :classroom, :parent_permission

  def initialize(age, classroom, name, parent_permission, id = 'undefined')
    super(age, name, id, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.student.push(self) unless classroom.student.includes?(self)
  end
end
