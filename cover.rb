require 'json'

class Cover
	def initialize(isbn, upc)
		@isbn = isbn
		@upc = upc
		@sources = Array.new()		
	end

	def checkSyndetics()
		s = SyndeticsSource.new
		s.check_cover(@isbn)
	end

	def checkOpenLibrary()
		s = OpenLibrarySource.new
		s.check_cover(@isbn)
	end

	def check_sources()
		syndetics_ci = checkSyndetics()
		@sources.push(syndetics_ci)
		open_library_ci = checkOpenLibrary()
		@sources.push(open_library_ci)
	end

	def sources_to_json()
		@sources.each.map{|source|
			source.to_json
		}		
	end

	def to_json(*a)		
		{
		'json_class' => self.class.name,
		'data' => {"isbn" => @isbn, "upc" => @upc, "sources" => sources_to_json}
		}.to_json(*a)		
		#instance_variables.each_with_object({}) { |var,hash| hash[var.to_s.delete("@")] = instance_variable_get(var) }		
	end
end