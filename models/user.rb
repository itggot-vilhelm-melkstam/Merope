class User
	include DataMapper::Resource

	property :id, Serial
	property :name, String, :required => true
	property :email, String, :required => true, :length => 256
	property :password, BCryptHash, :required => true
	property :rights, String, :default => "Elev"
	property :blocked, Boolean, :default => false

	has n, :issues
	has n, :articles
end
