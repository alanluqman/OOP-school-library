class Book
  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(date, person)
    @rentals = Rental.new(date, person, self)
  end

  attr_accessor :title, :author, :rentals
end
