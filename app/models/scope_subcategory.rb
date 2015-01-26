class ScopeSubcategory < ActiveRecord::Base
  belongs_to :scope_subject
  has_and_belongs_to_many :scope_databases
  attr_accessible :name
end
