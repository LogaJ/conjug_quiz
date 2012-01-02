require 'nokogiri'
require 'open-uri'
require 'babelfish'
require './verbs_and_conjugations'

verb_base = 'http://www.italian-verbs.com/verbi-italiani/verbi-italiani-top.php?pag='
conjug_base = 'http://www.italian-verbs.com/verbi-italiani/'

verbs = []
(1..1).each do |page_num|
  verb_url = "#{verb_base}#{page_num}"

  doc = Nokogiri::HTML(open("#{verb_url}", :proxy => nil)) do |config|
    config.strict.noerror
  end

  (4..6).each do |verb_number|
    node =  doc.xpath("/html/body/div/center/table/tr[3]/td[2]/center/div/center/table/tr[#{verb_number}]/td[3]/span/a")
    verb = node.inner_text
    conjug_url = node.attr("href").value

    unless VerbsAndConjugations.is_in_db? verb

      meaning = BabelFish.translate(verb, 'it', 'en')

      conjug_html_data = `curl #{conjug_base}#{conjug_url}`

      if conjug_html_data.match(/>(io .*?)<\/td>/)
        conjugations = $1.split("<br>")
        conjugations.map! { |conjugation| conjugation.match(/\w+\s+(\w+)/); $1 }
      end

      temp_conjugs = {
        :verb => verb, 
        :meaning => meaning, 
        :conjugations => conjugations
      }
      VerbsAndConjugations.store temp_conjugs
      verbs << temp_conjugs
    end
  end
end
puts verbs.inspect
