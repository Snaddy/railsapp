collection @comments

attributes :id, :content

child (:user) {attributes :username, :id, :avatar}
	
node(:posted_at) {|comment| comment.created_at.to_i}