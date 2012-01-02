conjug_base = 'http://www.italian-verbs.com/verbi-italiani/coniugazione.php?id=3542'

conjugations = []
test = `curl #{conjug_base}`

if test.match(/>(io .*?)<\/td>/)
  con = $1.split("<br>")
  con.map! { |foo| foo.match(/\w+\s+(\w+)/); $1 }
  puts con.inspect
end
