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
		Issue.create(title: "Banankaka fast i tangentbordet ocdakjhf jdhfk kdjfh kad",
								 description: "Jag käka banankaka och så bara 'whoops!'",
								 alternative_email: "majs@bajs.com",
								 user_id: 1)

    Issue.create(title: "Hejsan hoppsan",
    						 description: "Ja, vad ska man säga, det blir som det blir. Lorem ipsum dolmus sollicitudin luctus magna in laoreet. Sed eget venenatis nulla.",
                 status: :closed,
                 alternative_email: "majs@bajs.com",
                 user_id: 2)

    Issue.create(title: "Tjohej mesjk ",
                 description: "Bacon ipsum dolor amet beef pastrami porchetta leberkas, tail bresaola salami turducken. Kevin pork chop corned beef ground round beef ribs boudin pork brisket biltong.",
                 status: :closed,
                 alternative_email: "majs@bajs.com",
                 user_id: 2)
	end

	def self.articles
		Article.create(title: "Radergummi i örongången",
									 description: "Ta en penna och ät majs så blir det superduper",
									 user_id: 1)
	end

end
