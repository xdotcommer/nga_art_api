FROM ruby:3.2

WORKDIR /app
COPY . .

RUN gem install bundler && bundle install

CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "9292"]
