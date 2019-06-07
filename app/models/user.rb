class User


  DB = PG.connect({
    :host => "localhost",
    :port => 5432,
    :dbname => 'plane-rails_development'
    });

    #Prepared statements... in progress

    #GET: A user by id
    DB.prepare("users_find",
      <<-SQL
        SELECT users.*
        FROM users
        WHERE users.id = $1;
      SQL
    )

    #POST: A new user
    DB.prepare("users_create",
      <<-SQL
        INSERT INTO users (username, password)
        VALUES ($1, $2)
        RETURNING id, username, password;
      SQL
    )

    #DELETE: An existing user
    DB.prepare("users_delete",
      <<-SQL
        DELETE FROM users
        WHERE users.id = $1
        RETURNING id;
      SQL
    )

    # Routes... in progress

    #GET: Index of users - returns array of user objects
    def self.all
      results = DB.exec("SELECT * FROM users;");
      usersList = [];
      results.each do |result|
        usersList.push(result);
      end
      puts usersList;
      return usersList;
    end

    #GET: A user by id
    def self.find(id)
      results = DB.exec_prepared("users_find", [id]);
      return results.first;
    end

    #POST: A new user
    #Add encryption here?
    def self.create(options)
      newUsername = options["username"];
      newPassword = options["password"];

      result = DB.exec_prepared("users_create", [newUsername, newPassword]);

      return result.first
    end

    #DELETE: An existing user
    def self.delete(id)
      results = DB.exec_prepared("users_delete", [id]);
      return results.first;
    end


    #PUT: Edit an existing user
    def self.update()

    end

end #End user class
