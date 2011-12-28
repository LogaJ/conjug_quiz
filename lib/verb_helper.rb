def inform_user_if_no_verbs_were_found_on_conjugation_page
  @message = session[:message]
  session.clear
end


def create_or_find_specified_verb
  Verb.first_or_create name: params[:verb_name], meaning: params[:verb_meaning]
  return Verb
end
