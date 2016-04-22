class User
	include DataMapper::Resource

	property :id, Serial
	property :name, String, :required => true
	property :email, String, :required => true, :unique => true, :length => 256
	property :password, BCryptHash, :required => true
	property :blocked, Boolean, :default => false
	property :type, Discriminator

	#has 1, :student
	#has 1, :admin, required: false
	has n, :issues

end

class Admin < User
	include DataMapper::Resource


	belongs_to :user, key: true
	#has n, :articles
end

class Student < User
	include DataMapper::Resource

	belongs_to :user, key: true
	#has n, :issues
end
