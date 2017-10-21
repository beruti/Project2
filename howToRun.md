<h2>How to run Cabin Collective</h2>

add the following files to .gitignore


bundle install
to install all dependencies from Gemfile

rake db:create
to create the db
rake db:migrate
to account for any changes made for database

(prepend bundle exec to the above commands if not running to ensure dependencies are correct)

rails s on default port 3000 on localhost
to start server





----------NOTES------
rails server
to run the rails server

rails new Project2 -d postgresql
was used to initially setup the Rails app

#Postgres NOTES
psql --username={resultOfwhoamiCommand}
\l to list tables
\connect database_name
\dt: list all tables in the current database
\? for help on commands


cd /usr/local/Cellar/postgresql/10.0/bin/
#postgres location after brew installation
