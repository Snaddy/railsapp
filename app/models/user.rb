class User < ActiveRecord::Base
  acts_as_token_authenticatable
  acts_as_paranoid
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, password_length: 6..128
  
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  #user methods

  #follow
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  #unfollow
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  #is following
  def following?(other_user)
    !!self.following.find_by(user_id: other_user.id)
  end

  def post_count
    self.posts.count
  end

  def following_count
    self.following.count
  end

  def followers_count
    self.followers.count
  end

  #only get posts from self and followers
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # creates a new like row with post_id and user_id
  def like!(post)
    self.likes.create!(post_id: post.id)
  end

  # destroys a like with matching post_id and user_id
  def unlike!(post)
    like = self.likes.find_by(post_id: post.id)
    like.destroy!
  end

  # returns true of false if a post is liked by user
  def like?(post)
   !!self.likes.find_by(post_id: post.id)
  end 

  def search(search)
    find(:all, conditions: ['username LIKE ? OR name LIKE ?', "%#{search}%"])
  end

  #validation for user data
  validates_presence_of :username
  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :username, :case_sensitive => false, message: "This username has already been taken"
  validates_format_of :username, with: /\A[a-zA-Z0-9_]+\Z/
  validates :username, length: {in: 3..16}
  validates :name, length: {in: 1..30}
end
