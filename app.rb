require('bundler/setup')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload('lib/**/*.rb')
enable :sessions
# Route to the index
get('/') do
  @user = User.find(session[:id])
  erb(:index)
end

get '/user/signup' do
  erb :user_signup
end

get '/company/signup' do
  erb :company_signup
end

post('/user/signup') do
  @user = User.new(first_name: params['first_name'], last_name: params['last_name'], email: params['email'], password: params['password'])
  @user.save
  session[:type] = 'user'
  session[:id] = @user.id
  redirect '/user/home'
end

post('/company/signup') do
  @company = Company.new(name: params['name'], email: params['email'], password: params['password'])
  @company.save
  session[:type] = 'company'
  session[:id] = @company.id
  redirect '/company/home'
end

get('/user/home') do
  if session[:id] && session[:type] == 'user'
    @user = User.find(session[:id])
    erb(:user_home)
  elsif session[:id] && session[:type] == 'company'
    redirect('/company/home')
  else
    redirect('/user/login')
  end
end

get('/company/home') do
  if session[:id] && session[:type] == 'company'
    @company = Company.find(session[:id])
    erb(:company_home)
  elsif session[:id] && session[:type] == 'user'
    redirect('/user/home')
  else
    redirect('/company/login')
  end
end

get('/user/login') do
  if session[:id] && session[:type] == 'user'
    @user = User.find(session[:id])
    redirect('/user/home')
  elsif session[:id] && session[:type] == 'company'
    redirect('/company/home')
  else
    erb(:user_login)
  end
end

get('/company/login') do
  if session[:id] && session[:type] == 'company'
    redirect('/company/home')
  elsif session[:id] && session[:type] == 'user'
    redirect('/user/home')
  else
    erb(:company_login)
  end
end

post('/user') do
  @user = User.find_by(email: params['email'], password: params['password'])
  session[:id] = @user.id
  session[:type] = 'user'
  redirect('/user/home')
end

post('/company') do
  @company = Company.find_by(email: params['email'], password: params['password'])
  session[:id] = @company.id
  session[:type] = 'company'
  redirect('/company/home')
end

get '/logout' do
  session.clear
  redirect('/')
end

post('/payment_methods')do
  user = params.fetch('user_id')
  name = params.fetch('method_name')
  acc_no = params.fetch('method_acc_no')
  provider = params.fetch('method_provider')
  new_payment_method = PaymentMethod.new(user_id:user,name:name,acc_no:acc_no,provider:provider)
  new_payment_method.save
  redirect('/user/home')
end
