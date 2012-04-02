class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
 
    if user.role?(:admin)
      can :manage, :all
    end

    # Examples. Uncomment and change.
    #if user.role?(:admin)
    #  can :manage, :all
    #elsif user.role?(:master)
    #  # Master can manage only own works
    #  can :manage, Master, :id => user.id
    #  can :manage, MasterWork, :master => { :id => user.id }
    #end
  end
end
