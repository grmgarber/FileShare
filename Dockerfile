#https://github.com/phusion/passenger-docker
FROM phusion/passenger-ruby24
ENV HOME /root

# Use baseimage-docker init process
CMD ["/sbin/my_init"]

# Additional package to be able to ping DB service
#RUN apt-get update && apt-get install -y -o Dpkg::Options::="force-confold" netcat

# Enable nginx and passenger
RUN rm -f /etc/service/nginx/down

# Add virtual host entry for the application
RUN rm /etc/nginx/sites-enabled/default
ADD fupl.conf /etc/nginx/sites-enabled/fupl.conf

# If we need env variables for nginx
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

# Install gems.  It is better to have an independent layer for them
WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN bundle install


COPY . /home/app/fupl
RUN usermod -u 1000 app
RUN chown -R app:app /home/app/fupl
WORKDIR /home/app/fupl
RUN bundle exec rake db:schema:load

# Clean up apt
RUN apt-get clean & rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 80
