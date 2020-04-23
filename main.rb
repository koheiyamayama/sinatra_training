require 'mysql2'
require 'sinatra'

sleep 2

DB = Mysql2::Client.new(:host => "db", :username => "root", :password => "root", :database => "sinatra_training_db", :port => 3306, :reconnect => true)

get '/' do
  @posts = DB.query('select * from posts;')
  erb :'posts/index'
end

get '/posts/new' do
  erb :'posts/new'
end

get '/posts/:id' do
  statement = DB.prepare('select * from posts where id = ?')
  @post = statement.execute(params[:id]).first
  erb :'posts/show'
end

post '/posts' do
  statement = DB.prepare('insert into posts (title, body, user_id) values (?, ?, ?)')
  statement.execute(params[:title], params[:body], params[:user_id])
  redirect '/'
end

get '/users/:id' do
  statement_fetch_user = DB.prepare('select * from users where id = ?')
  @user = statement_fetch_user.execute(params[:id]).first
  statement_fetch_posts = DB.prepare('select * from posts where user_id = ?')
  @posts = statement_fetch_posts.execute(params[:id])
  erb :'users/show'
end

get '/users' do
  @users = DB.query('select * from users;')
  erb :'users/index'
end
