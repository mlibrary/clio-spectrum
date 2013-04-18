class Ability
  include CanCan::Ability


  def initialize(user)
    user ||= User.new

    if user.has_role?('item_alerts', 'manage') 
      can :manage, ItemAlert
    end

    if user.has_role?('user', 'impersonate')
      can :impersonate, User
    end
  end
end
