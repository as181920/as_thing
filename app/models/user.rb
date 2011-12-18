class User < ActiveRecord::Base
  has_many :followships, :foreign_key => "follower_id"
  has_many :following, :through => :followships, :source => :followed
  has_many :reverse_followships, :foreign_key => "followed_id", :class_name => "Followship"
  has_many :followers, :through => :reverse_followships, :source => :follower

  has_many :relationships, :foreign_key => "follower_id"
  has_many :fd_notes, :through => :relationships, :source => :fd_note

  has_many :ownerships
  has_many :as_notes, :through => :ownerships

  attr_accessible :nick_name, :email, :password, :password_confirmation

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on=>:create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "email format not appropriate!" }

  def self.authenticate(email,password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
      user
    else
      nil
    end
  end

  def note_following?(followed)
    relationships.find_by_fd_note_id(followed)
  end

  def note_follow!(followed)
    relationships.create!(:fd_note_id => followed.id)
  end

  def note_unfollow!(followed)
    relationships.find_by_fd_note_id(followed).destroy
  end


  def following?(followed)
    followships.find_by_followed_id(followed)
  end

  def follow!(followed)
    followships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    followships.find_by_followed_id(followed).destroy
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
