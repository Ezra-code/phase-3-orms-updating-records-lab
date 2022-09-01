require_relative "../config/environment.rb"

class Student
    def initialize(name:, grade:, id: nil)
      @grade = grade
      @name = name
      @id = id
    end

   def self.create_table
        sql = <<-SQL
            CREATE TABLE IF NOT EXISTS sudents(
                id INTEGER PRIMARY KEY,
                name TEXT,
                grade TEXT
            )
        SQL

        DB[:conn].execute(sql)
    end

    def self.drop_table
      sql = <<-SQL
        DROP TABLE IF EXISTS students
        SQL

        DB[:conn].execute(sql)

    end

    def save
      sql = <<-SQL
      INSERT INTO students(name, grade)
      VALUES(?, ?)
        SQL

        DB[:conn].execute(sql, self.name, self.grade)

        self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]

        self
    end

end
