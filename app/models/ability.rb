class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    
    if user.role? :admin
      can :manage, :all
    elsif user.role? :chama
      can :manage, Chama do |chama|
        chama.try(:owner) == user
      end
    else
      can :read, :all
    end
  end
end

