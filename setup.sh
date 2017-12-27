#!/bin/sh

# dbms is the hostname of the mysql service instance in docker-compose; 3306 is mysql default port

echo "Waiting for MySQL to start on port 3306..."
while ! nc -z dbms 3306; do
    sleep 0.5
done

echo "MySQL database has started up"
# in rails 5 you can do 'bin rails db:migrate'
sleep 3.0
bundle exec rake db:migrate
