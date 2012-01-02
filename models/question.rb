require 'data_mapper'

DataMapper.setup(
  :default,
  :adapter => 'postgres',
  :host => 'localhost',
  :database => 'conjugapp',
  :encoding => 'UTF-8'
)

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
