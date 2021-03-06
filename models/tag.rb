class Tag
	include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true

  has n, :issuetaggings
  has n, :issues, through: :issuetaggings
end
