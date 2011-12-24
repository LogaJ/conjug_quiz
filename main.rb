require 'sinatra'
require './models/question'

enable :sessions

get '/' do
  'hi'
end

get '/new/verb' do
  @message = session[:message]
  session.clear

  erb :new_verb
end

post '/new/verb' do
  Verb.create name: params[:verb_name], meaning: params[:verb_meaning]
  redirect '/new/verb'
end

get '/new/conjugation' do
  @verbs = Verb.all

  if @verbs.empty?
    session[:message] = 'no verbs'

    redirect 'new/verb'
  end

  erb :new_conjugation
end

post '/new/conjugation' do
  verb = Verb.get(params[:verb_id])
  conjugation = verb.conjugations

  conjugation.all(person: params[:person], 
    singular_or_plural: params[:singular_plural]).destroy

  conjugation.create person: params[:person], 
    singular_or_plural: params[:singular_plural], value: params[:conjug_name]

  redirect '/new/conjugation'
end
