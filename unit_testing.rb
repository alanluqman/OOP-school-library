require './book'
require './person'
require './student'
require './teacher'
require './classroom'

# Test Book Class
describe Book do
  it 'Test book attributes' do
    book = Book.new('Romeo and Juliet', 'William Shakespeare')

    expect(book.title).to eq 'Romeo and Juliet'
    expect(book.author).to eq 'William Shakespeare'
  end
end

# Test Person Class
describe Person do
  it 'Test Person attributes' do
    person = Person.new(27, 'William')

    expect(person.name).to eq 'William'
    expect(person.age).to eq 27
    expect(person.can_use_servises?).to be_truthy
  end
end

# Test Student Class
describe Student do 
  it 'Test Student attributes' do
    student = Student.new(17, 4, 'Jan', true)

    expect(student.name).to eq 'Jan'
    expect(student.age).to eq 17
    expect(student.classroom).to eq 4
    expect(student.can_use_servises?).to be_truthy
    expect(student).to be_an_instance_of(Student)
  end
end

# Test Teacher Class
describe Teacher do
  it 'Test Teacher attributes' do
    teacher = Teacher.new('Ruby', 33, 'Ernest')

    expect(teacher.name).to eq 'Ernest'
    expect(teacher.age).to eq 33
    expect(teacher.can_use_servises?).to be_truthy
    expect(teacher).to be_an_instance_of(Teacher)
  end
end

# Test Classroom Class
describe Classroom do
  it 'Test Teacher attributes' do
    new_class = Classroom.new('Legends')

    expect(new_class.label).to eq 'Legends'
    expect(new_class.student_list).to eq []
  end
end
