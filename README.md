# project_four_rails

Database setup: plane-rails_development
-table: users (id, username, password)


In rails folder:
  $ rails db:create

In psql:
  $ CREATE TABLE users (id SERIAL, username VARCHAR(255), password VARCHAR(255));
  
  $ INSERT INTO users (username, password) VALUES ('TestNameHere', 'GoodPass');
