FROM ruby:latest
RUN apt-get update 
RUN apt-get install -y mariadb-client 
RUN gem install mysql2 sinatra
RUN mkdir /app
WORKDIR /app
COPY ./ /app
