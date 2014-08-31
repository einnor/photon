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

      # Chama can only access itself
      can :read, Chama, :user_id => user.id

      # A Chama can read and update its settings record
      can :ru, Setting, :chama_id => user.chama.id

      # A Chama can read and update its Service Fee record
      can :ru, ServiceFee, :chama_id => user.chama.id

      # A Chama can read and update its Message Manager record
      can :ru, MessageManager, :chama_id => user.chama.id

      # A Chama can read and update its SMS Fee record
      can :cru, SmsFee, :chama_id => user.chama.id

      # A Chama can create, update, read and delete its Members
      can :crud, Member, :chama_id => user.chama.id

      #
      # Rules for Less Security Concious Models
      #

      # A Chama can create, update, read and delete its Events records
      can :crud, Event, :chama_id => user.chama.id

      # A Chama can create, update, read and delete its Loans records
      can :create, Loan
      can :rud, Loan do | loan |
        loan.member.chama.id == user.chama.id
      end

      # A Chama can create, update, read and delete its Loan Repayment records
      can :create, LoanRepayment
      can :rud, LoanRepayment do | lr |
        lr.loan.member.chama.id == user.chama.id
      end


      # A Chama can create, update, read and delete its Messages
      can :create, Message
      can :rud, Message do | msg |
        msg.message_manager.chama.id == user.chama.id
      end

      # A Chama can create, update, read and delete its Penalties records
      can :crud, Penalty
      can :rud, Penalty do | penalty |
        penalty.member.chama.id == user.chama.id
      end

      # A Chama can create, update, read and delete its Penalty Repayment records
      can :create, PenaltyRepayment
      can :rud, PenaltyRepayment do | pr |
        pr.penalty.member.chama.id == user.chama.id
      end

      # A Chama can create, update, read and delete its Remittance records
      can :create, Remittance
      can :rud, Remittance do | remittance |
        remittance.member.chama.id == user.chama.id
      end

      # A Chama can create, update, read and delete its Withdrawal records
      can :crud, Withdrawal, :chama_id => user.chama.id

    else
      can :read, :none
    end
  end
end

