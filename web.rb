require 'sinatra'
require "#{Dir.pwd}/lib/application_helper"

enable :sessions

def auth user
  condition do
    redirect '/login' unless user_logged_in?
  end
end

get '/', :auth => :user do
  erb :index
end

get '/login' do
  erb :login, :layout => false
end

post '/login' do
  correct_login_details? params[:username], params[:password]
end

get '/login_error' do
  tell_user_they_entered_incorrect_details

  erb :user_login_error, :layout => false
end

get '/logout' do
  session[:user] = nil
  redirect '/login'
end

get '/new/quiz', :auth => :user do
  @questions = generate_question_info_for random_conjugations

  erb :new_quiz
end

post '/check/answers', :auth => :user do
  @answers = compare_correct_answers_with params

  erb :quiz_scores
end

get '/new/verb', :auth => :user do
  inform_user_if_no_verbs_were_found_on_conjugation_page

  erb :new_verb
end

post '/new/verb', :auth => :user do
  create_or_find_specified_verb

  redirect '/new/verb'
end

get '/new/conjugation', :auth => :user do
  conjugation_finder

  before_creating_conjugation_check_if_there_are_any_verbs

  erb :new_conjugation
end

post '/new/conjugation', :auth => :user do
  create_or_update_conjugation

  redirect '/new/conjugation'
end

get '/ajax/conjugation', :auth => :user do
  erb :display_conjugation, :layout => false
end

post '/ajax/conjugation', :auth => :user do
  return_value_for_existing_cojugation

  erb :display_conjugation, :layout => false
end
