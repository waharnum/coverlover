class CoverMongo

	def self.get_cover_collection()
		client = MongoClient.new("localhost",27017)
		db = client.db("coverdb")
		coll = db.collection("covercollection")
		return coll
	end

	def self.has_isbn(isbn)
		coll = get_cover_collection()
		matches = coll.find({'data.isbn' => isbn})		
		if(matches.count > 0) 
			return true
		else 
			return false
		end
	end

	def self.get_isbn(isbn)
		coll = get_cover_collection()
		matches = coll.find_one({'data.isbn' => isbn})	
		return matches
	end

	def self.store_cover(cover)
		coll = get_cover_collection()
		id = coll.insert(JSON.parse(cover.to_json()))
		return id
	end
end