FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /pumps
WORKDIR /pumps
COPY Gemfile /pumps/Gemfile
COPY Gemfile.lock /pumps/Gemfile.lock
RUN bundle install
COPY . /pumps
Run touch /db.dump
COPY latest.dump /db.dump
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - \
        && apt-get install -y nodejs
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]