class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    # Alias actions
    alias_action :create, :read, :update, :destroy, :to => :crud
    alias_action :create, :read, :update :to => :cru
    alias_action :read, :update :to => :ru
    
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
      chama_members = Member.where(:chama_id => user.chama_id)
      chama_loans = Loan.where(:member_id => chama_members)
      message_manager = user.chama.message_manager
      chama_penalties = Penalty.where(:member_id => chama_members)

      # A Chama can create, update, read and delete its Events records
      can :crud, Event, :chama_id => user.chama.id

      # A Chama can create, update, read and delete its Loans records
      can :crud, Loan, :member_id => chama_members

      # A Chama can create, update, read and delete its Loan Repayment records
      can :crud, LoanRepayment, :loan_id => chama_loans


      # A Chama can create, update, read and delete its Messages
      can :crud, Message, :message_manager_id => message_manager.id

      # A Chama can create, update, read and delete its Penalties records
      can :crud, Penalty, :member_id => chama_members

      # A Chama can create, update, read and delete its Penalty Repayment records
      can :crud, PenaltyRepayment, :penalty_id => chama_penalties

      # A Chama can create, update, read and delete its Remittance records
      can :crud, Remittance, :member_id => chama_members

      # A Chama can create, update, read and delete its Withdrawal records
      can :crud, Withdrawal, :chama_id => user.chama.id

    else
      can :read, :none
    end
  end
end

