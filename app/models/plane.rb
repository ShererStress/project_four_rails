class Plane

  DB = PG.connect({
    :host => "localhost",
    :port => 5432,
    :dbname => 'plane-rails_development'
    });

    # #GET: A plane by id
    # DB.prepare("planes_find",
    #   <<-SQL
    #     SELECT planes.*
    #     FROM planes
    #     WHERE planes.id = $1;
    #   SQL
    # );
    #
    # #POST: A new user
    # DB.prepare("planes_create",
    #   <<-SQL
    #     INSERT INTO planes (username, password)
    #     VALUES ($1, $2)
    #     RETURNING id, username, password;
    #   SQL
    # );
    #
    # #DELETE: An existing user
    # DB.prepare("planes_delete",
    #   <<-SQL
    #     DELETE FROM planes
    #     WHERE planes.id = $1
    #     RETURNING id;
    #   SQL
    # );




    #GET: Index of users - returns array of plane objects
    def self.all
      results = DB.exec("SELECT * FROM planes;");
      usersList = [];
      results.each do |result|
        usersList.push(result);
      end
      puts usersList;
      return usersList;
    end
    #
    # #GET: A plane by id
    # def self.find(id)
    #   results = DB.exec_prepared("users_find", [id]);
    #   return results.first;
    # end
    #
    # #POST: A new plane
    # #Add encryption here? (Don't forget the update route, too!)
    # def self.create(options)
    #   newUsername = options["username"];
    #   newPassword = options["password"];
    #
    #   result = DB.exec_prepared("users_create", [newUsername, newPassword]);
    #
    #   return result.first
    # end
    #
    # #DELETE: An existing plane
    # def self.delete(id)
    #   results = DB.exec_prepared("users_delete", [id]);
    #   return results.first;
    # end

end #End plane class
