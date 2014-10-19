class User < ActiveRecord::Base
    
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :authentication_keys => [:login]

  # Virtual Login attribute
  attr_accessor :login

  # Send messages to other users
  acts_as_messageable

  has_and_belongs_to_many :roles
  has_many :posts
  has_many :comments, :through => :posts
  has_one :like, :through => :posts
  has_many :authorizations
  
  before_save :setup_role

  # Validate fields
  validates :name, presence: true
  validates :email, presence: true

  # Validate username
  validates :username, presence: true,
             length: {maximum: 255},
             uniqueness: { case_sensitive: false }, 
             format: { with: /\A[a-zA-Z0-9]*\z/, message: "may only contain letters and numbers." }

  def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end

  # Default role is "Chama" - role for chama administrators
  def setup_role 
    if self.role_ids.empty?     
      self.role_ids = [2] 
    end
  end

  # Virtual login attributes
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end
  
  
  def self.new_with_session(params,session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"],without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.from_omniauth(auth, current_user)
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s, :token => auth.credentials.token, :secret => auth.credentials.secret).first_or_initialize
    if authorization.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth["info"]["email"]).first : current_user
      if user.blank?
       user = User.new
       user.password = Devise.friendly_token[0,10]
       user.name = auth.info.name
       user.email = auth.info.email
       #auth.provider == "twitter" ?  user.save(:validate => false) :  user.save
       
       
       if auth.provider == "twitter"
        #code
        user.email = "#{user.name}_email@example.com"
        user.save(:validate => false)
      else
        user.save
       end
       
       
    end
     authorization.username = auth.info.nickname
     authorization.user_id = user.id
     authorization.save
   end
   authorization.user
 end
  

  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  

# End users
end
