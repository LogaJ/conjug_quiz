def correct_login_details? username, password
  if (session[:user] = User.authenticate(username, password))
    redirect '/'
  else
    session[:message] = 'Login details incorrect. Please try again.'
    redirect '/login_error'
  end
end

def tell_user_they_entered_incorrect_details
  @login_error = session[:message]
  session.clear
end

def user_logged_in?
  if session[:user]
    @user = session[:user]
    return @user
  else 
    return nil
  end
end

