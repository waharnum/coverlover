class CoverInfo
	attr_accessor :source_name
	attr_accessor :last_checked
	attr_accessor :url
	attr_accessor :has_cover
	attr_accessor :isbn
	attr_accessor :upc
	@source_name
	@last_checked
	@url
	@has_cover
	@isbn
	@upc

	def initialize(source_name)
		@source_name = source_name
	end	

	def to_json
		instance_variables.each_with_object({}) { |var,hash| hash[var.to_s.delete("@")] = instance_variable_get(var) }		
	end
end