#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'


def get_db
	db = SQLite3::Database.new 'Users.db'
	db.results_as_hash = true
	return db
end

configure do
	db = get_db
	db.execute 'CREATE TABLE IF NOT EXISTS
		"Users"
		(
			"id" INTEGER PRIMARY KEY AUTOINCREMENT,
			"username" TEXT,
			"userphone" TEXT,
			"datestamp" TEXT,
			"barber" TEXT
		)'
		db.execute 'CREATE TABLE IF NOT EXISTS
		"Barbers"
		(
			"id" INTEGER PRIMARY KEY AUTOINCREMENT,
			"name" TEXT
		)'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do
	@username = params[:username]
	@userphone = params[:userphone]
	@datetime = params[:datetime]
	@barber = params[:barber]

	hh = {  :username => 'Введите имя', 
			:userphone => 'Введите номер телефона', 
			:datetime => 'Введите дату и время'	}
	@error = hh.select {|key,_| params[key] == ''}.values.join(", ")
	if @error != ''
  		return erb :visit
	end

	db = get_db
	db.execute 'INSERT INTO "Users" (username, userphone, datestamp, barber) values (?, ?, ?, ?)', [@username, @userphone, @datetime, @barber]
	erb "Уважаемый #{@username}, ждем Вас #{@datetime}"
end

get '/contacts' do
	erb :contacts
end

get '/user' do
  erb :user
end

get '/showusers' do
  
end

post '/user' do
  @login = params[:login]
  @password = params[:password]

  # проверим логин и пароль, и пускаем внутрь или нет:
  if @login == 'admin' && @password == 'p@ss'
 	db = get_db
 	@results = db.execute 'select * from Users order by id desc'
  	erb :watch_result
  else
    @report = '<p>Доступ запрещён! Неправильный логин или пароль.</p>'
    erb :user
  end
end