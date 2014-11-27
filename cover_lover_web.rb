require './cover'
require './cover_source'
require './syndetics_source'
require './open_library_source'
require './cover_info'
require './cover_mongo'
require 'sinatra'

get '/cover/isbn/:isbn' do
  isbn = params[:isbn]  
  cover = Cover.new(isbn,"")  
  cover.check_sources()
  "#{cover.to_json}"
end