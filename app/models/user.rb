class User < ActiveRecord::Base
  acts_as_token_authenticatable
  acts_as_paranoid
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, password_length: 6..128
  
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  #relationships
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  #people the user has blocked
  has_many :active_blocks, class_name: "Block", foreign_key: "user_id", dependent: :destroy
  has_many :blocking, through: :active_blocks, source: :user 
  #people who have blocked user
  has_many :passive_blocks, class_name: "Block", foreign_key: "blocking_id", dependent: :destroy
  has_many :blocked, through: :passive_blocks, source: :blocking
  #user methods
  #follow
  def follow!(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  #unfollow
  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy!
  end

  #is following
  def following?(other_user)
    !!self.following.find_by(id: other_user.id)
  end

  def block!(other_user)
    active_blocks.create(blocking_id: other_user.id)
  end

  def unblock!(other_user)
    active_blocks.find_by(blocking_id: other_user.id).destroy!
  end

  def blocking?(other_user)
    !!self.blocking.find_by(id: other_user.id)
  end

  def blocked?(other_user)
    !!self.blocked.find_by(id: other_user.id)
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

  def self.search(search)
    User.where('username LIKE :search OR name LIKE :search', search: "%#{search}%")
  end

  def self.username_exists?(username)
    !!User.exists?(username: username)
  end

  def self.email_exists?(email)
    !!User.exists?(email: email)
  end

  #validation for user data
  validates_presence_of :username
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :gender
  validates_length_of :bio, :maximum => 250, :allow_blank => true
  validates_uniqueness_of :username, :case_sensitive => false, message: "This username has already been taken"
  validates_format_of :username, with: /^([A-Za-z0-9_](?:(?:[A-Za-z0-9_]|(?:\.(?!\.))){0,28}(?:[A-Za-z0-9_]))?)$/, multiline: true
  validates :username, length: {in: 1..20}
  validates :name, length: {in: 1..30}

end
