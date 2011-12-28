def conjugation_finder
  @custom_js = '<script type="text/javascript" src="/js/conjugation_finder.js"></script>'
end

def before_creating_conjugation_check_if_there_are_any_verbs
  @verbs = Verb.all
  if @verbs.empty?
    session[:message] = 'There are no verbs, you must first add a verb before you can add a conjugation.'
    redirect 'new/verb'
  end
end

def create_or_update_conjugation
  verb = Verb.get(params[:verb_id])
  conjugation = verb.conjugations

  conjugation.all(person: params[:person], 
                  singular_or_plural: params[:singular_plural]).destroy

  conjugation.create person: params[:person], 
    singular_or_plural: params[:singular_plural], value: params[:conjug_name]
end

def return_value_for_existing_cojugation
  verb_id = params[:verb]
  person = params[:person]
  number = params[:number]

  verb = Verb.get(verb_id)
  already_existing_conjugation = verb.conjugations.first(:person => person, :singular_or_plural => number)

  if already_existing_conjugation 
    @conjugation = already_existing_conjugation.value

  end
end
