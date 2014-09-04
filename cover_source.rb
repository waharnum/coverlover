class CoverSource
	attr_accessor :name
	def initialize(name)
		@name = name
	end

	def check_cover
		raise NotImplementedError, "You must implement the check_cover method"
	end
end