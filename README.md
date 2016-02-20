### Install

git clone git@github.com:raecoo/sinatra-template.git
cd sinatra-template
bundle install

### Rake Task

* rake db:create_migration  # Create a migration at ./db/migrate/{NAME}
* rake db:migrate           # Run database migrations
* rake db:reset             # Reset the database
* rake db:rollback          # Rollback last migration
* rake db:schema            # Output the schema to db/schema.rb
* rake spec                 # Run all tests
* rake spec:models          # Run all model tests
* rake spec:routes          # Run all route tests