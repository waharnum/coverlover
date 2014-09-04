require './cover'
require './cover_source'
require './syndetics_source'
require './cover_info'

c = Cover.new(9780316228466,"")
ci = c.checkSyndetics()
puts "#{ci.source_name} | #{ci.last_checked} | #{ci.url} | #{ci.has_cover}"
