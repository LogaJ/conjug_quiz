require 'httparty'
require 'json'

def get_translation_for verb
	response = HTTParty.get("http://translate.google.gr/translate_a/t?client=t&text=#{verb}&hl=en&sl=it&tl=en&ie=UTF-8&oe=UTF-8&multires=1&source=tws_lsugg&prev=conf&psl=it&ptl=it&otf=1&it=sel.1792&ssel=3&tsel=6&sc=1").body.force_encoding("UTF-8").scan(/\w+/).first

	return "to #{response}"
end
