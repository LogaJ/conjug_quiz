require 'sinatra'
require 'pry'
require "#{Dir.pwd}/lib/application_helper"

enable :sessions, :logging

get '/' do
  erb :index
end

get '/new/quiz' do
  @questions = generate_question_info_for random_conjugations

  erb :new_quiz
end

post '/check/answers' do
  @answers = compare_correct_answers_with params

  erb :quiz_scores
end

get '/new/verb' do
  inform_user_if_no_verbs_were_found_on_conjugation_page

  erb :new_verb
end

post '/new/verb' do
  create_or_find_specified_verb

  redirect '/new/verb'
end

get '/new/conjugation' do
  conjugation_finder

  before_creating_conjugation_check_if_there_are_any_verbs

  erb :new_conjugation
end

post '/new/conjugation' do
  create_or_update_conjugation

  redirect '/new/conjugation'
end

get '/ajax/conjugation' do
  erb :display_conjugation, :layout => false
end

post '/ajax/conjugation' do
  return_value_for_existing_cojugation

  erb :display_conjugation, :layout => false
end
