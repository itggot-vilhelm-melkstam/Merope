class Issue
	include DataMapper::Resource

	property :id, Serial
	property :title, String, :required => true, :length => 140
	property :description, Text, :required => true
	property :status, Enum[:unassigned, :open, :closed], default: :unassigned
	property :created_at, DateTime
	property :notice, Boolean, :default => true
	property :alternative_email, String, :length => 256, :required => false
	property :admin, Integer

	belongs_to :user
	has n, :issuetaggings
	has n, :tags, through: :issuetaggings
end
