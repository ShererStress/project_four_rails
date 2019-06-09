In-between# project_four_rails

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

# User Stories
-MVP Requirements
A visitor to the site can:
-Create a new user account
-log in with an existign user account
-Edit and delete that user account

-Stretch
A visitor to the site can hopefully:
View a map that:
  -Displays the location of aircraft from opensky-network
  -These aircraft pins update on each new API call
  -In-between calls, the markers move based on velocity data
Interact with the aircraft pins:
  -Select them to view additional data
  -Add them to a tracker to keep track of it passively
See what aircraft pins other users are tracking


# To-do List
MVP:
-Rails API for users; contains id, username, password
-React frontend; allows a visitor to create a user, log in, then edit and delete information for that user.
-Make changes to allow for deployment on Heroku


-Stretch
-Get map displaying in its own Component.
-Make api call from opensky-network for live plane data.
-Use tracking data to create pins.
-Limit refresh to specific timer.
-Implement SASS animations to cover gaps between refresh.
-Have pins clickable to display info.
-Allow user to add flight to myTracker.
-Implement socket to display user/other users names above flights being tracked.
