get '/' do
  # render home page
 #TODO: Show all users if user is signed in
  @users = User.all
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page 
  erb :sign_in
end

post '/sessions' do
  
  @user = User.authenticate(params[:email], params[:password])
  if @user
    session[:id] = @user.id
    redirect "/"
  else
    @errors = "Please enter your email and password again."
    erb :sign_in
  end
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  session.clear
  redirect '/'
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users' do
  # sign-up a new user
  @user = User.new(params[:user])
  if @user.save
    session[:id] = @user.id
    redirect '/'
  else
    @errors = @user.errors.full_messages
    erb :sign_up
  end

end

# A user can SignUp for a new account with an email and password.
# User passwords are stored encrypted in the password-hash field. 
#You may implement this yourself or use the bcyrpt gem.
# An existing user can SignIn
# If a user is not signed in, they only see a welcome message on the home page.
# If a user is signed in, they can see all users on the home page.
# A user can SignOut using the provided delete route which is invoked via AJAX.
# A helper method current_user returns the current signed in user and is 
# used to display appropriate SignIn / SignOut portions of the view. 
# (This logic is already implemented in the view - you just need to finish 
#   the helper method).



