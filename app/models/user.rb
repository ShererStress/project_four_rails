class User


  DB = PG.connect({
    :host => "localhost",
    :port => 5432,
    :dbname => 'plane-rails_development'
    });

    #Prepared statements... in progress
    DB.prepare("users_find",
      <<-SQL
        SELECT users.*
        FROM users
        WHERE users.id = $1;
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

    def self.find(id)
      results = DB.exec_prepared("users_find", [id]);
      return results.first;
    end


end #End user class
