require './cover'
require './cover_source'
require './syndetics_source'
require './open_library_source'
require './cover_info'
require './cover_mongo'
require 'sinatra'
require 'mongo'
require 'json'
include Mongo

get '/cover/isbn/:isbn' do
  isbn = params[:isbn]  

  if(CoverMongo.has_isbn(isbn))
  	"
  	<h1>Cover Located in Mongo</h1>
  	#{CoverMongo.get_isbn(isbn)}
  	"
  else
  	cover = Cover.new(isbn,"")  
  	cover.check_sources()
  	"<h1>Cover Not Located in Mongo</h1>
  	#{cover.to_json}
  	Information stored in Mongo with ID#{CoverMongo.store_cover(cover)}"
  end

end