When /^I add the conjugation for "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)"$/ do |verb, person, number, name|

  visit 'new/conjugation'

  select verb, :from => 'verb_id'
  select person, :from => 'person'
  select number, :from => 'singular_plural'
  fill_in 'conjug_name', :with => name

  click_button 'Add Conjugation'
end
