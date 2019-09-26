class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql =  <<-SQL 
  CREATE TABLE students (
  id INTEGER PRIMARY KEY,
  grade INTEGER,
  name TEXT
  )
  SQL
  DB[:conn].execute(sql) 
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
        SQL
    DB[:conn].execute(sql)  
  end

  def save
    sql = <<-SQL
      INSERT INTO students (grade, name)
        VALUES (?, ?)
        SQL
    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT id FROM students")
  end



  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student
  end


end