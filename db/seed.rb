class Seeder

  def self.seed!
    #Delete all files
    Dir["./public/files/*"].each {|file| File.delete(file)}

		users
		issues
    tags
    comments
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
		10.times do
			Issue.create(title: LoremIpsum.random.split(/ /)[0..rand(3..6)].join(" "),
									 description: LoremIpsum.random(paragraphs: rand(1..3)),
									 status: [:unassigned, :open, :closed].sample,
									 user: User.all.sample)

    # Issue.create(title: "Hejsan hoppsan",
    # 						 description: "Ja, vad ska man säga, det blir som det blir. Lorem ipsum dolmus sollicitudin luctus magna in laoreet. Sed eget venenatis nulla.",
    #              status: :closed,
    #              user_id: 2)
		#
    # Issue.create(title: "Tjohej mesjk ",
    #              description: "Bacon ipsum dolor amet beef pastrami porchetta leberkas, tail bresaola salami turducken. Kevin pork chop corned beef ground round beef ribs boudin pork brisket biltong.",
    #              status: :closed,
    #              user_id: 2)
		end
	end

	def self.articles
		Article.create(title: "Radergummi i örongången",
									 description: "Ta en penna och ät majs så blir det superduper",
									 user_id: 1)
	end

  def self.tags
    Tag.create(name: "Dator")
    Tag.create(name: "Windows")
    Tag.create(name: "Mac OSX")
    Tag.create(name: "Inloggning")
    Tag.create(name: "Övrig hårdvara")
    Tag.create(name: "Övrig mjukvara")
  end

  def self.comments
    Comment.create(content: "Hej!", issue_id: 1, user_id: 2)
  end

end
