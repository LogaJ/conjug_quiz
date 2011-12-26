require 'sinatra'
require './models/question'

enable :sessions

class ConjugQuiz < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/new/quiz' do
    conjugations = Conjugation.all
    conjugations = conjugations.sample(10)

    @questions = generate_question_info_for conjugations

    erb :new_quiz
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
    @custom_js = '<script type="text/javascript" src="/js/conjugation_finder.js"></script>'

    @verbs = Verb.all

    if @verbs.empty?
      session[:message] = 'There are no verbs, you must first add a verb before you can add a conjugation.'

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


  get '/ajax/conjugation' do
    erb :get_conjugation, :layout => false
  end

  post '/ajax/conjugation' do
    verb_id = params[:verb]
    person = params[:person]
    number = params[:number]

    verb = Verb.get(verb_id)
    already_existing_conjugation = verb.conjugations.first(:person => person, :singular_or_plural => number)

    if already_existing_conjugation 
      @conjugation = already_existing_conjugation.value

      erb :get_conjugation, :layout => false
    end
  end

  def generate_question_info_for conjugations
    info_for_all_questions = []

    conjugations.each do |conjugation|

      info_for_one_question = {:verb => Verb.get(conjugation.verb_id), :conjugation => conjugation}
      info_for_all_questions << info_for_one_question

    end
    return info_for_all_questions
  end
end
