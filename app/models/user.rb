class User < ActiveRecord::Base
  include AASM
  
  aasm_column :state
  
  aasm_initial_state :created
  
  aasm_state :created
  aasm_state :registered
  aasm_state :activated
  
  aasm_event :processing do
    transitions :to => :registered, :from => [:created]
  end
  
  aasm_event :confirm do
    transitions :to => :activated, :from => [:registered]
  end
  
  attr_accessor :password
  
  validates_confirmation_of :password
  validates_presence_of :password
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_presence_of :name
  
  before_save :encrypt_password
  
  has_many :projects, :through => :user_projects
  has_many :user_projects
  has_many :tasks
  has_many :comments
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password) && (user.active?)
    nil
  end
  
  def remember_me!
    self.remember_token = encrypt("#{salt}--#{id}--#{Time.now.utc}")
    save_without_validation
  end
  
  def register
    self.confirmation_token = encrypt("#{id}--#{Time.now.utc}")
    self.processing!
  end
  
  def active?
    confirmation_token.nil?
  end
  
  def confirmation
    self.confirm!
    self.update_attribute(:confirmation_token, nil)
  end
  
  def made_scrum
    self.update_attribute(:scrum, true)
  end
  
  def self.generate_password
    User.make_password
  end

  def self.make_password
    rand(100).to_s + ('a'..'z').to_a.shuffle[0..2].join + rand(100).to_s + ('a'..'z').to_a.shuffle[0..2].join
  end
  
  def self.scrum_reminder
    User.all.each do |user|
      if user.enrolled && !user.scrum?
        UserMailer.deliver_scrum_reminder(user)
      end
    end
  end
  
  def enroll
    self.update_attribute(:enrolled, true)
  end
  
  def not_enroll
    if self.user_projects.empty?
      self.update_attribute(:enrolled, false)
    end
  end
  
  def self.reset_scrum
    update_all("scrum = false")
  end
  
  private
  
  def encrypt_password
    unless password.nil? || password.blank?
      self.salt = make_salt(password)
      self.encrypted_password = encrypt(password)
    end
  end
  
  def encrypt(string)
    secure_hash("#{salt}#{string}")
  end
  
  def make_salt(password)
    secure_hash("#{Time.now.utc}#{password}")
  end
  
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
  
  
end
