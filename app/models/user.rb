class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :roles
  before_save :setup_role

  # Validate fields
  validates :name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :national_id_number, presence: true

  def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end

  # Default role is "Chama" - role for chama administrators
  def setup_role 
    if self.role_ids.empty?     
      self.role_ids = [2] 
    end
  end
end
