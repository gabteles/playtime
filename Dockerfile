FROM ruby:2.4.1
RUN mkdir /app
WORKDIR /app
ADD . /app
RUN DEBIAN_FRONTEND=noninteractive apt update && apt install -y nodejs
RUN bundle install
EXPOSE 5000
