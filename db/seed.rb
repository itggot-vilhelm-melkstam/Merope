class Seeder

  def self.seed!
		users
		issues
		articles
  end

	def self.users
		User.create(name: "Vilhelm Melkstam",
								email: "vilhelm.melkstam@gmail.com",
								password: "Hej")

		User.create(name: "Pelle K.Lund",
								email: "tramstrams@gmail.com",
								password: "majsmajs",
								rights: :admin)

	end

	def self.issues
		Issue.create(title: "Banankaka fast i tangentbordet",
								 description: "Jag käka banankaka och så bara 'whoops!'",
								 alternative_email: "majs@bajs.com",
								 user_id: 1)
	end

	def self.articles
		Article.create(title: "Radergummi i örongången",
									 description: "Ta en penna och ät majs så blir det superduper",
									 user_id: 1)
	end

end
