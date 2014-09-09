class CoverMongo
	def self.has_isbn(isbn)
		client = MongoClient.new("localhost",27017)
		db = client.db("coverdb")
		coll = db.collection("covercollection")
		matches = coll.find("isbn" => isbn)		
		if(matches.count > 0) 
			return true
		else 
			return false
		end
	end
end