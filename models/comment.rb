class Comment
	include DataMapper::Resource

	property :id, Serial
	property :content, Text, required: true
	# property :status, Enum[:comment, :status_closed, :question, :information], default: :comment
	property :created_at, DateTime

	belongs_to :user
	belongs_to :issue
end
