
# "CanCan is a simple authorization plugin that offers a lot of flexibility"
#     http://railscasts.com/episodes/192-authorization-with-cancan

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Manage alerts, access-requirements, etc., for 'Databases'
    if user.has_role?('item_alerts', 'manage')
      can :manage, ItemAlert
    end

    # Can manage scoped-search definitions
    if user.has_role?('scoped_search', 'manage')
      can :manage, ScopeQuickSet
    end
  end
end
