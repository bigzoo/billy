require('bundler/setup')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload('lib/**/*.rb')
enable :sessions
# Route to the index
get('/') do
  if session[:id] && session[:type] == 'user'
    @user = User.find(session[:id])
  elsif session[:id] && session[:type] == 'company'
    @company = Company.find(session[:id])
  end
  erb(:index)
end

# start of sign up and login methods

get '/user/signup' do
  erb :user_signup
end

get '/company/signup' do
  erb :company_signup
end

post('/user/signup') do
  @user = User.new(first_name: params['first_name'], last_name: params['last_name'], email: params['email'], password: params['password'])
  @user.save
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
  @companies = Company.all
  if session[:id]
    @user = User.find(session[:id])
    erb(:user_home)
  elsif session[:id] && session[:type] == 'company'
    redirect('/company/home')
  else
    redirect('/user/login')
  end
end

get('/company/home') do
  if session[:id]
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

post('/user_account') do
  user = User.find(session[:id])
  national_id = params.fetch('national_id')
  national_id = user.national_id if national_id == ''
  first_name = params.fetch('first_name')
  first_name = user.first_name if first_name == ''
  last_name = params.fetch('last_name')
  last_name = user.last_name if last_name == ''
  username = params.fetch('username')
  username = user.username if username == ''
  phone_no = params.fetch('phone_no')
  phone_no = user.phone_no if phone_no == ''
  image = params.fetch('image')
  image = user.image if image == ''
  user.update(national_id: national_id, first_name: first_name, last_name: last_name, username: username, phone_no: phone_no, image: image)
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

# end of sign in and login methods

# company_home
get('/companies/:id') do
  @company = Company.find(params.fetch('id').to_i)
  @user_accounts = User_account.all
  erb(:company_home)
end

post('/company_accounts') do
  company_id = params.fetch('company_id').to_i
  national_id = params.fetch('user_national_id')
  name = params.fetch('user_reg_name')
  account_no = params.fetch('account_no')
  balance = params.fetch('balance')
  due_date = params.fetch('due_date')
  CompanyAccount.create(company_id: company_id, user_national_id: national_id, user_reg_name: name, account_no: account_no, balance: balance, due_date: due_date)
  redirect('/company/home')
end


#update method
get('/company_accounts/:id/edit')do
  @company_account = CompanyAccount.find(params.fetch("id").to_i)
  @company = Company.find(session[:id])
  erb(:company_account_edit)
end

patch('/company_accounts/:id') do
  company_account = CompanyAccount.find(params.fetch('id').to_i)
  national_id = params.fetch('user_national_id')
  name = params.fetch('user_reg_name')

  account_no = params.fetch('account_no')
  if account_no==''
    account_no=company_account.account_no
  end

  balance = params.fetch('balance')
  if balance==''
    balance=company_account.balance
  end

  due_date = params.fetch('due_date')
  if due_date==''
    due_date=company_account.due_date
  end
  @company_account = CompanyAccount.find(params.fetch('id').to_i)
  @company_account.update(user_national_id: national_id, user_reg_name: name, account_no: account_no, balance: balance, due_date: due_date)
  @company_accounts = CompanyAccount.all
  redirect '/company/home'
end

# end of company home

# payment methods
post('/payment_methods') do
  user = params.fetch('user_id')
  name = params.fetch('method_name')
  acc_no = params.fetch('method_acc_no')
  provider = params.fetch('method_provider')
  new_payment_method = PaymentMethod.new(user_id: user, name: name, acc_no: acc_no, provider: provider)
  new_payment_method.save
  redirect('/user/home')
end

get('/user/profile') do
  @user = User.find(session[:id])
  erb(:user_profile)
end

get('/user/accounts/:id') do
  if session[:type] == 'user'
    @user = User.find(session[:id])
    @user_account = UserAccount.find(params.fetch('id').to_i)
    @company_account = @user_account.company_account
    @payment_methods = @user.payment_methods
    erb(:user_account_home)
  elsif session[:type] == 'company'
    redirect('/company/home')
  else
    redirect('/user/login')
  end
end

get('/user/payment_methods/:id') do
  if session[:type] == 'user'
    @user = User.find(session[:id])
    @payment_method = PaymentMethod.find(params.fetch('id').to_i)
    @payments = Payment.where(user_id: @user.id, payment_method: @payment_method.id)
    erb(:user_payment_method)
  elsif session[:type] == 'company'
    redirect('/company/home')
  else
    redirect('/user/login')
  end
end

post('/user_accounts') do
  user = User.find(session[:id])
  account_no = params.fetch('account_no').to_i
  company = Company.find(params.fetch('company_id').to_i)
  company_account = CompanyAccount.find_by(account_no: account_no, company_id: company.id)
  if company_account
    user_account = UserAccount.new(user_id: user.id, company_account_id: company_account.id, account_no: account_no, name: company_account.company.name.concat(' Account For ' + company_account.user_reg_name))
    user_account.save
    redirect('/user/home')
  else
    @error = 'No account with no ' + account_no.to_s + ' was found associated with the company you selected.'
    @user = User.find(session[:id])
    @companies = Company.all
    erb(:user_home)
  end
end

post('/payments') do
  user = User.find(session[:id])
  payment_method = PaymentMethod.find(params.fetch('payment_method').to_i)
  user_account = UserAccount.find(params.fetch('user_account').to_i)
  amount = params.fetch('amount').to_i
  company = Company.find(params.fetch('company').to_i)
  new_payment = Payment.new(user_id: user.id, payment_method_id: payment_method.id, user_account_id: user_account.id, amount: amount, company_id: company.id)
  new_payment.save
  company_account = user_account.company_account
  new_balance = company_account.balance + amount
  company_account.update(balance: new_balance)
  redirect('/user/home')
end
