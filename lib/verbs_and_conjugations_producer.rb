require './models/question.rb' 

class VerbsAndConjugations
  def self.is_in_db? verb
    Verb.first(:name => verb)
  end
  def self.store verb_and_conjugations
    unless is_in_db? verb_and_conjugations[:verb]

      conjugations = verb_and_conjugations[:conjugations]

      Verb.create(:name => verb_and_conjugations[:verb], 
                  :meaning => verb_and_conjugations[:meaning])

      verb = Verb.first(:name => verb_and_conjugations[:verb])
			#maybe the verb isn't being saved into the db??
      conjugations_for_verb = verb.conjugations


      ['singular','plural'].each do |number|
        ['1st', '2nd', '3rd'].each do |person|
          conjugation = conjugations.shift 

          conjugations_for_verb.create(
            :verb_id => verb.id, 
            :person => person,
            :singular_or_plural => number,
            :value => conjugation
          )
        end
      end
    end
  end
end
