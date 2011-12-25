require 'sinatra'
require './models/question'

enable :sessions

class ConjugQuiz < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/new/quiz' do
    verb = Verb.get(12)
    conjugation = verb.conjugations.get(17)

    @question_one = "What is the #{conjugation.person} person #{conjugation.singular_or_plural} for the verb: #{verb.name} (#{verb.meaning})?"

    erb :quiz
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
    @function = "function checkConjugation() {
      var verb = $('verb_id').value
      var person = $('person').value
      var singular_plural = $('singular_plural').value

      var url     = '/ajax/conjugation';
      var options = {
        method : 'post',
        parameters : {
          verb    : verb,
          person  : person,
          number  : singular_plural
        },
        onComplete : getResponse
      };
      new Ajax.Request(url, options);
    }
    
    function getResponse(oReq) {
      $('conjug_name').value = oReq.responseText;
    }"
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
    verb = params[:verb]
    person = params[:person]
    number = params[:number]

    puts "#{verb}, #{person}, #{number}"

    my_verb = Verb.get(verb)
    con = my_verb.conjugations.first(:person => person, :singular_or_plural => number)

    if con 
      @conjugation = con.value

      erb :get_conjugation, :layout => false
    end
  end
end
