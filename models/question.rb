require 'data_mapper'
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Verb
  include DataMapper::Resource
  property :id, Serial
  property :name, String, :required => true
  property :meaning, String, :required => true

  has n, :conjugations
end

class Conjugation
  include DataMapper::Resource
  property :conjugation_id, Serial, :required => true
  property :person, String, :required => true
  property :singular_or_plural, String, :required => true
  property :value, String, :required => true

  belongs_to :verb
end

DataMapper.finalize
