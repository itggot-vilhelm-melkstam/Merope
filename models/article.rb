class Article
	include DataMapper::Resource

	property :id, Serial
	property :title, String, :required => true, :length => 140
	property :description, Text, :required => true
	property :created_at, DateTime

	belongs_to :user
end
