In-between# project_four_rails

Collaborators:
Owen Orrison
https://github.com/OwenOrrison

See front-end readme for complete project description:
Front-end: https://github.com/OwenOrrison/plane-react
Active site: https://whispering-mesa-41107.herokuapp.com/


Local database setup for: plane-rails_development
  table: users (id, username, password)
  table: planes (id, icao_ID, linked_User_ID)

In rails folder:
  $ rails db:create

In psql:
  $ CREATE TABLE users (id SERIAL, username VARCHAR(255), password VARCHAR(255));
  $ INSERT INTO users (username, password) VALUES ('TestNameHere', 'GoodPass');
  $ SELECT * FROM users;

  $ CREATE TABLE planes (id SERIAL, icao_ID VARCHAR(16), linked_User_ID SMALLINT);
  $ INSERT INTO planes (icao_ID, linked_User_ID) VALUES ('aaa222', 1);

The user and plane model will have to be edited to access a local database - they are currently set to access an external database.
