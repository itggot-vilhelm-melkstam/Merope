class Attachment
	include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true
  property :path, FilePath
  property :created_at, DateTime

	belongs_to :issue, required: false
end
