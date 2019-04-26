#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

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
	hh.each do |key, value|
		if params[key] == ''
			@error = hh[key]
			return erb :visit
		end
	end
#	if @username == ''
#		@error = 'Введите имя'
#	end
#	if @userphone == ''
#		@error = 'Введите номер телефона'
#	end
#	if @datetime == ''
#		@error = 'Введите дату и время'
#	end
#	if @error != ''
#		erb :visit
	f = File.open './public/users.txt', 'a'
	f.write "User: #{@username}, phone: #{@userphone}, date & time: #{@datetime}, barber: #{@barber}\n"
	f.close
	erb "Уважаемый #{@username}, ждем Вас #{@datetime}"
end

get '/contacts' do
	erb :contacts
end

get '/user' do
  erb :user
end

post '/user' do
  @login = params[:login]
  @password = params[:password]

  # проверим логин и пароль, и пускаем внутрь или нет:
  if @login == 'admin' && @password == 'p@ss'
    @file = File.open("./public/users.txt","r")
    erb :watch_result
    # @file.close - должно быть, но тогда не работает. указал в erb
  else
    @report = '<p>Доступ запрещён! Неправильный логин или пароль.</p>'
    erb :user
  end
end