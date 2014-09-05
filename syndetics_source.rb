require './cover_info'
require './cover_source'
require 'date'
require 'net/http'

class SyndeticsSource < CoverSource

	def initialize
		super("Syndetics")
	end	

	def check_cover(isbn)		
		syndetics_base = "syndetics.com"
		syndetics_path = "/index.aspx?isbn=#{isbn}/SC.gif"
		puts "Checking image in #{@name} at #{syndetics_base}#{syndetics_path}"
		content_length = 0

		Net::HTTP.start(syndetics_base) do |http|
		  http.open_timeout = 2
		  http.read_timeout = 2
		  content_length = http.head(syndetics_path)["content-length"]		  
		end

		puts content_length

		ci = CoverInfo.new("Syndetics")
		ci.last_checked = Date.today.to_s		
		ci.isbn = isbn.to_s		
		
		
		if(content_length.to_i > 100)
			puts "Syndetics has a cover image!"
			ci.has_cover = true
			ci.url = syndetics_base+syndetics_path
		else
			puts "Syndetics has no cover image!"
			ci.has_cover = false
		end		

		return ci				
	end

end