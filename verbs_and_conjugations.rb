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
      conjugation = verb.conjugations


      ['singular','plural'].each do |number|
        ['1st', '2nd', '3rd'].each do |person|
          cong = conjugations.shift 
          conjug = cong.encode!("UTF-8")
          puts "~~~~~~~~"
          puts conjug
          puts "~~~~~~~~"

          conjugation.create(
            :verb_id => verb.id, 
            :person => person,
            :singular_or_plural => number,
            :value => conjug
          )
        end
      end
    end
  end
end
