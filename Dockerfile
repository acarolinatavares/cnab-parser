FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /cnab-parser
WORKDIR /cnab-parser
COPY Gemfile /cnab-parser/Gemfile
COPY Gemfile.lock /cnab-parser/Gemfile.lock
RUN bundle install
COPY . /cnab-parser

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]