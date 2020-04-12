require 'mysql2'

client = Mysql2::Client.new(:host => "db", :username => "root", :password => "root", :database => "sinatra_training_db", :port => 3306, :reconnect => true)

client.query <<-SQL
  create table if not exists posts (
    id integer primary key auto_increment,
    user_id integer,
    title varchar(255),
    body text
  );
SQL

client.query <<-SQL
  create table if not exists users (
    id integer primary key auto_increment,
    name varchar(255)
  );
SQL

(Date.new(2020,04,01)...Date.new(2020,04,30)).each do |date|
  client.query <<-SQL
    insert into posts (user_id, title, body) values ("1", "#{date}の一日", "hogehoge")
  SQL
end

client.query("insert into users (name) values ('kohei');")
