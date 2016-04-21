class Issue
	include DataMapper::Resource

	property :id, Serial
	property :title, String, :required => true, :length => 140
	property :description, Text, :required => true
	property :created_at, DateTime
	property :notice, Boolean, :required => true, :default => true
	property :alternative_email, String, :required => true, :length => 256

	belongs_to :user
end
