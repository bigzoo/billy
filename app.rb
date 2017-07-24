require('bundler/setup')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload('lib/**/*.rb')
enable :sessions
#Route to the index
get('/') do
  erb(:index)
end

get '/user/signup' do
    erb (:user_signup)
end

get '/company/signup' do
    erb (:company_signup)
end

post('/user/signup')do
@user = User.new(first_name: params["first_name"],last_name: params["last_name"], email: params["email"], password: params["password"])
@user.save
session[:id] = @user.id
redirect '/user/home'
end

post('/company/signup')do
@user = Company.new(name: params["name"], email: params["email"], password: params["password"])
@user.save
session[:id] = @user.id
redirect '/company/home'
end

get('/user/home')do
  if session[:id]
    @user = User.find(session[:id])
    erb(:user_home)
  else
    redirect('/user/login')
  end
end

get('/company/home')do
  if session[:id]
    @company = Company.find(session[:id])
    erb(:company_home)
  else
    redirect('/company/login')
  end

end

get('/user/login')do
  erb(:user_login)
end

get('/company/login')do
  erb(:company_login)
end

post('/user')do
@user = User.find_by(email: params["email"], password: params["password"])
session[:id] = @user.id
redirect('/company/home')
end

post('/company')do
@company = Company.find_by(email: params["email"], password: params["password"])
session[:id] = @company.id
redirect('/user/home')
end

get '/logout'do
  session.clear
  redirect('/')
end
