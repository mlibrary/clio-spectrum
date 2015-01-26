class ScopeQuickSet < ActiveRecord::Base
  has_and_belongs_to_many :scope_databases
  attr_accessible :name
end
