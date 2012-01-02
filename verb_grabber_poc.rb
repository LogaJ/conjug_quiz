require 'nokogiri'
require 'open-uri'
require 'babelfish'
require './verbs_and_conjugations'

base = 'http://www.italian-verbs.com/verbi-italiani/verbi-italiani-top.php?pag='

verbs = []
(1..1).each do |page_num|
  verb_url = "#{base}#{page_num}"
  doc = Nokogiri::HTML(open("#{verb_url}", :proxy => nil)) do |config|
    config.strict.noerror
  end

  (4..14).each do |verb_number|
    node =  doc.xpath("/html/body/div/center/table/tr[3]/td[2]/center/div/center/table/tr[#{verb_number}]/td[3]/span/a")
    verb = node.inner_text
    unless VerbsAndConjugations.is_in_db? verb
      meaning = BabelFish.translate(verb, 'it', 'en', :proxy => nil)
      verbs << {
        :verb => verb, 
        :url => node.attr("href").value, 
        :meaning => meaning 
      }
    end
  end
end

conjug_base = 'http://www.italian-verbs.com/verbi-italiani/'

verbs.each do |verb|
  html_data = `curl #{conjug_base}#{verb[:url]}`

  if html_data.match(/>(io .*?)<\/td>/)
    conjugations = $1.split("<br>")
    conjugations.map! { |conjugation| conjugation.match(/\w+\s+(\w+)/); $1 }
    verb[:conjugation] = conjugations
  end
end
puts verbs.inspect
