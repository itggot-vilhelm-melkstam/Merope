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
  								password: "Hej",
  								rights: :admin)

    10.times do
      User.create(name: Faker::Name.name,
  								email: Faker::Internet.email,
  								password: "Hej",
  								rights: [:admin, :teacher, :student, :student, :student].sample)
    end
	end

	def self.issues
		10.times do
			Issue.create(title: LoremIpsum.random.split(/ /)[0..rand(3..6)].join(" "),
									 description: LoremIpsum.random(paragraphs: rand(1..3)),
									 status: [:unassigned, :open, :closed].sample,
									 user: User.all.sample,
                   created_at: Faker::Time.backward(365, :all).to_datetime)
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
