class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  # Virtual Login attribute
  attr_accessor :login

  has_and_belongs_to_many :roles
  before_save :setup_role

  # Validate fields
  validates :name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :national_id_number, presence: true

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
