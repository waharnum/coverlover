require './cover'
require './cover_source'
require './syndetics_source'
require './open_library_source'
require './cover_info'
require './cover_mongo'
require 'mongo'
require 'json'
include Mongo

isbns = ["9780670026326","9780345549365","9780765328021","1481404911","9780375870644","9781443136167","9782701182995","9782896607730","9782714456519","9782810005727","1595341897","9781442369801","0785190104","9781608183395","9781621697862","0062235796","1550820249"]

# isbns = ["0062235796","1550820249"]

# isbn = "9780670026326"

client = MongoClient.new("localhost",27017)
db = client.db("coverdb")
coll = db.collection("covercollection")

 

isbns.each do |isbn|
	c = Cover.new(isbn,"")

	puts "Checking ISBN #{isbn}"

	puts "Checking mongo"	
	matches = coll.find_one({'data.isbn' => isbn})		
	if (CoverMongo.has_isbn(isbn))
	puts "There's a match in mongo"				
		puts "Match: #{matches}"
		currentDate = Date.today
		puts currentDate
		# checkDate = Date.parse(match["last_checked"])
		# checkDate = Date.parse("2014-08-24")
		# days_since_check = (currentDate - checkDate).to_i
		# puts "Days since check: #{days_since_check}"

	else
	puts "No match in mongo, checking image with providers"
	c.check_sources()		
	# puts "JSON: #{c.to_json().class}"	
	puts "Storing in Mongo"	
	id = coll.insert(JSON.parse(c.to_json()))
	puts "stored with ID #{id}"
	puts "--------------------------"
	puts "--------------------------"
	puts
	end
end

# puts "Deleting mongo data"
# coll.remove


# Count of found documents
# puts matches.count
# Document

  


