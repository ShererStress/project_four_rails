class Plane

  if(ENV['DATABASE_URL'])
    uri = URI.parse(ENV['DATABASE_URL'])
    DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
  else
    DB = PG.connect(host: "localhost", port: 5432, dbname: 'plane-rails_development')
  end


  #Prepared Statements
  #GET: A plane by id
  DB.prepare("planes_find",
    <<-SQL
    SELECT planes.*
    FROM planes
    WHERE planes.id = $1;
    SQL
  );

  #Checks for an existing plane by icao_id and linked_user_id
  DB.prepare("planes_find_existing",
    <<-SQL
      SELECT planes.*
      FROM planes
      WHERE planes.icao_id = $1 AND  planes.linked_user_id = $2;
    SQL
  );

  #POST: A new plane
  DB.prepare("planes_create",
    <<-SQL
    INSERT INTO planes (icao_id, linked_user_id)
    VALUES ($1, $2)
    RETURNING id, icao_id, linked_user_id;
    SQL
  );

  #DELETE: An existing plane by id
  DB.prepare("planes_delete",
    <<-SQL
    DELETE FROM planes
    WHERE planes.id = $1
    RETURNING id;
    SQL
  );

    #Route methods

  #GET: Index of users - returns array of plane objects with all columns, joined by the connected users
  def self.all
    results = DB.exec("SELECT *, planes.id AS plane_database_id FROM planes JOIN users ON planes.linked_user_id = users.id ORDER BY planes.icao_id ASC;");
    usersList = [];
    results.each do |result|
      usersList.push(result);
    end
    puts usersList;
    return usersList;
  end

  #GET: A plane by id - returns all columns
  def self.find(id)
    results = DB.exec_prepared("planes_find", [id]);
    return results.first;
  end

  #POST: A new plane - returns all columns
  #Only posts if that specific userID/planeICAO combination does not exist in the database
  def self.create(options)
    planeICAO = options["planeData"];
    userID = options["userData"];

    doesExist = false;
    planeCheck = DB.exec_prepared("planes_find_existing", [planeICAO,userID]);
    puts planeCheck.first;
    if(planeCheck.first === nil)
      result = DB.exec_prepared("planes_create", [planeICAO, userID]);
      return result.first;
    else
      return nil;
    end
  end

  #DELETE: An existing plane - returns id(serial) of deleted plane
  def self.delete(id)
    results = DB.exec_prepared("planes_delete", [id]);
    return results.first;
  end

end #End plane class
