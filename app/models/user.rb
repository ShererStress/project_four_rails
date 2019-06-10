class User

  DB = PG.connect({
    :host => "localhost",
    :port => 5432,
    :dbname => 'plane-rails_development'
    });

    #GET: A user by username/password match
    DB.prepare("users_authenticate",
      <<-SQL
        SELECT *
        FROM users
        WHERE username = $1 AND password= $2;
      SQL
    );

    #GET: A user by id
    DB.prepare("users_find",
      <<-SQL
        SELECT users.id AS id, users.username, planes.id AS plane_database_id, planes.icao_id
        FROM users JOIN planes
        ON users.id = planes.linked_user_id
        WHERE users.id = $1;
      SQL
    );

    #POST: A new user
    DB.prepare("users_create",
      <<-SQL
        INSERT INTO users (username, password)
        VALUES ($1, $2)
        RETURNING id, username, password;
      SQL
    );

    #DELETE: An existing user
    DB.prepare("users_delete",
      <<-SQL
        DELETE FROM users
        WHERE users.id = $1
        RETURNING id;
      SQL
    );

    #PUT: Edit an existing user
    DB.prepare("users_update",
      <<-SQL
        UPDATE users
        SET username = $2, password = $3
        WHERE id = $1
        RETURNING id, username, password;
      SQL
    );


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
      return results;
    end

    #POST: Check for user by username/password match
    def self.authenticate(options)
      enteredUsername = options["username"];
      enteredPassword = options["password"];
      results = DB.exec_prepared("users_authenticate", [enteredUsername, enteredPassword]);

      return results.first;
    end

    #POST: A new user
    #Add encryption here? (Don't forget the update route, too!)
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
    #Add encryption here, as well!
    def self.update(id, options)
      newUsername = options["username"];
      newPassword = options["password"];

      results = DB.exec_prepared("users_update", [id, newUsername, newPassword]);

      return results.first;
    end

end #End user class
