FROM ruby:2.5-alpine

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME
CMD bundle exec ruby app.rb -o 0.0.0.0