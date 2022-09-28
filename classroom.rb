class Classroom
  def initialize(label)
    @label = label
    @student_list = []
  end

  attr_accessor :label
  attr_accessor :student_list

  def add_student(student_name)
    @student_list.push(student_name)
    student_name.classroom = self
  end
end
