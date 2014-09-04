require 'open-uri'
require 'RMagick'
require 'date'
include Magick

class SyndeticsSource < CoverSource

	def initialize
		super("Syndetics")
	end	

	def check_cover(isbn)		
		syndetics_url = "http://syndetics.com/index.aspx?isbn=#{isbn}/SC.gif"
		puts "Checking image in #{@name} at #{syndetics_url}"
		syndetics_file = "#{isbn}-SC.gif";
		open(syndetics_url) {|f|			
			File.open("#{syndetics_file}", "w") do |file|
				file.puts f.read
			end
		}

		ci = CoverInfo.new("Syndetics")
		ci.last_checked = Date.today.to_s
		ci.url = syndetics_url	
		ci.isbn = isbn.to_s		

		lc = ImageList.new(syndetics_file)
		if(lc.columns > 1)
			puts "Syndetics has a cover image!"
			ci.has_cover = true
		else
			puts "Syndetics has no cover image!"
			ci.has_cover = false
		end		

		File.delete(syndetics_file)

		return ci				
	end

end