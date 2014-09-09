# http://covers.openlibrary.org/b/isbn/1550820249-S.jpg

require './cover_info'
require './cover_source'
require 'date'
require 'net/http'

class OpenLibrarySource < CoverSource

	def initialize
		super("Open Library")
	end	

	def check_cover(isbn)		
		source_base = "covers.openlibrary.org"
		source_path = "/b/isbn/#{isbn}-S.jpg"
		puts "Checking image in #{@name} at #{source_base}#{source_path}"
		content_length = 0
		location = ""
		Net::HTTP.start(source_base) do |http|
			# TODO: etags and If-Modified-Since
		  http.open_timeout = 2
		  http.read_timeout = 2
		  location = http.head(source_path)["location"]			  
		end

		puts "Open Library location: #{location}" 

			ci = CoverInfo.new("Open Library")
		ci.last_checked = Date.today.to_s		
		ci.isbn = isbn.to_s		
		
		
		if(location.to_s.length > 1)
			puts "Open Library has a cover image!"
			ci.has_cover = true
			ci.url = source_base+source_path
		else
			puts "Open Library has no cover image!"
			ci.has_cover = false
		end		

		return ci				

		
	end

end