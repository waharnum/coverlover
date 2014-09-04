require './cover'
require './cover_source'
require './syndetics_source'
require './cover_info'
require './cover_mongo'
require 'mongo'
include Mongo

isbn = "9780316228466"
c = Cover.new(isbn,"")

puts "Checking mongo"
client = MongoClient.new("localhost",27017)
db = client.db("coverdb")
coll = db.collection("covercollection")
matches = coll.find("isbn" => isbn)

if (CoverMongo.has_isbn(isbn))
puts "There's a match in mongo"
	match = matches.to_a[0]
	puts "\tProvider is: " + match["source_name"]
	puts "\tLast checked on: " + match["last_checked"]	
	puts "\tURL is: " + match["url"]		
	currentDate = Date.today
	puts currentDate
	# checkDate = Date.parse(match["last_checked"])
	checkDate = Date.parse("2014-08-24")
	days_since_check = (currentDate - checkDate).to_i
	puts "Days since check: #{days_since_check}"

else
puts "No match in mongo"
end



# Count of found documents
# puts matches.count
# Document



=begin
	
ci = c.checkSyndetics()
puts "#{ci.source_name} | #{ci.last_checked} | #{ci.url} | #{ci.has_cover}"
ci_json = ci.instance_variables.each_with_object({}) { |var,hash| hash[var.to_s.delete("@")] = ci.instance_variable_get(var) }
	
=end

# puts "Storing in Mongo"

# id = coll.insert(ci_json)
# puts "stored with ID #{id}"

# puts "Deleting mongo data"
# coll.remove


