require './cover'
require './cover_source'
require './syndetics_source'
require './cover_info'
require './cover_mongo'
require 'mongo'
include Mongo

isbns = ["9780670026326","9780345549365","9780765328021","1481404911","9780375870644","9781443136167","9782701182995","9782896607730","9782714456519","9782810005727","1595341897","9781442369801","0785190104","9781608183395","9781621697862","0062235796"]

# isbn = "9780670026326"

client = MongoClient.new("localhost",27017)
db = client.db("coverdb")
coll = db.collection("covercollection")

isbns.sample(5).each do |isbn|
	c = Cover.new(isbn,"")

	puts "Checking ISBN #{isbn}"

	puts "Checking mongo"
	matches = coll.find("isbn" => isbn)

	if (CoverMongo.has_isbn(isbn))
	puts "There's a match in mongo"		
		match = matches.to_a[0]
		puts "\tHas cover?: #{match['has_cover']}"
		puts "\tProvider is: #{match['source_name']}" 
		puts "\tLast checked on: #{match['last_checked']}"
		puts "\tURL is: #{match['url']}"
		puts "\tMongo ID is: #{match['_id']}"
		currentDate = Date.today
		puts currentDate
		checkDate = Date.parse(match["last_checked"])
		# checkDate = Date.parse("2014-08-24")
		days_since_check = (currentDate - checkDate).to_i
		puts "Days since check: #{days_since_check}"

	else
	puts "No match in mongo, checking image with providers"
	ci = c.checkSyndetics()
	# puts "#{ci.source_name} | #{ci.last_checked} | #{ci.url} | #{ci.has_cover}"
	ci_json = ci.instance_variables.each_with_object({}) { |var,hash| hash[var.to_s.delete("@")] = ci.instance_variable_get(var) }
	puts "Storing in Mongo"

	id = coll.insert(ci_json)
	puts "stored with ID #{id}"
	puts "--------------------------"
	puts "--------------------------"
	puts
	end
end




# Count of found documents
# puts matches.count
# Document

#  puts "Deleting mongo data"
 # coll.remove


