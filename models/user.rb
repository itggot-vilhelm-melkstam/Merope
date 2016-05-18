class User
	include DataMapper::Resource

	property :id, Serial
	property :name, String, :required => true
	property :email, String, :required => true, :unique => true, :length => 256
	property :password, BCryptHash, :required => true
	property :blocked, Boolean, :default => false
	property :rights, Enum[:admin, :teacher, :student], default: :student

	has n, :issues
	has n, :comments
end
