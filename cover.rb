class Cover
	def initialize(isbn, upc)
		@isbn = isbn
		@upc = upc
		sources = []		
	end

	def checkSyndetics()
		s = SyndeticsSource.new
		s.check_cover(@isbn)
	end
end