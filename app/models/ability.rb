class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    # Alias actions
    alias_action :create, :read, :update, :destroy, :to => :crud
    alias_action :create, :read, :update, :to => :cru
    alias_action :read, :update, :to => :ru
    alias_action :read, :update, :destroy, :to => :rud

    alias_action :create, :read, :to => :cr
    alias_action :update, :destroy, :to => :ud
    
    if user.role? :admin
      can :manage, :all
    elsif user.role? :chama
      # Custom Access control Rules

      #
      # Rules for Security Concious Models.
      #
      can :read, :all
            
    else
      can :read, :none
    end
  end
end

