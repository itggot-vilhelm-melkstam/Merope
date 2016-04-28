# class Tag_Article
# 	include DataMapper::Resource
#
# end
#
class Issuetagging
	include DataMapper::Resource

  belongs_to :tag, key: true
  belongs_to :issue, key: true
end
