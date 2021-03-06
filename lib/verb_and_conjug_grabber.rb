require 'nokogiri'
require 'open-uri'
require_relative './verbs_and_conjugations_producer'
require_relative './translation_response'

verb_base = 'http://www.italian-verbs.com/verbi-italiani/verbi-italiani-top.php?pag='
conjug_base = 'http://www.italian-verbs.com/verbi-italiani/'

verbs = []
(1..4).each do |page_num|
  verb_url = "#{verb_base}#{page_num}"

  doc = Nokogiri::HTML(open("#{verb_url}", :proxy => nil)) do |config|
    config.strict.noerror
  end

  (4..53).each do |verb_number|
    node =  doc.xpath("/html/body/div/center/table/tr[3]/td[2]/center/div/center/table/tr[#{verb_number}]/td[3]/span/a")
    verb = node.inner_text
    conjug_url = node.attr("href").value

    unless VerbsAndConjugations.is_in_db? verb

			meaning = get_translation_for verb

			conjug_html_data = `curl #{conjug_base}#{conjug_url}`

			begin
				if conjug_html_data.match(/>(io .*?)<\/td>/)
					conjugations = $1.split("<br>")
					conjugations.map! { |conjugation| conjugation.match(/^\w+\s+(.*)$/); $1 }
				else
					next
				end
			rescue
				next
			end

			temp_conjugs = {
				:verb => verb, 
				:meaning => meaning, 
				:conjugations => conjugations
			}
			VerbsAndConjugations.store temp_conjugs
		end
	end
end
