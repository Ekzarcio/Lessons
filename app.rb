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

	if @username == ''
		@error = 'Введите имя'
		erb :visit
	elsif @userphone == ''
		@error = 'Введите номер телефона'
		erb :visit
	elsif @datetime == ''
		@error = 'Введите дату и время'
		erb :visit
	else
		f = File.open './public/users.txt', 'a'
		f.write "User: #{@username}, phone: #{@userphone}, date & time: #{@datetime}, barber: #{@barber}\n"
		f.close
		erb "Уважаемый #{@username}, ждем Вас #{@datetime}"
	end
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