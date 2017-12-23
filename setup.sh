#!/bin/sh

# fupl_my_db_1 is the hostname of the mysql service instance in docker-compose; 3306 is mysql default port
echo "Waiting PostgreSQL to start on port 3306..."
while ! nc -z fupl_my_db_1 3306; do
    sleep 0.1
done

echo "mysql database has started up"
# in rails 5 you can do 'bin rails db:migrate'
bundle exec rake db:migrate