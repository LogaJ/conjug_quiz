When /^I add the verb "([^"]*)" with meaning "([^"]*)"$/ do |verb, meaning|
  visit 'new/verb'

  fill_in('verb_name', :with => verb)
  fill_in('verb_meaning', :with => meaning)
  click_button 'Add Verb'
end
