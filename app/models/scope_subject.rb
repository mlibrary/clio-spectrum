class ScopeSubject < ActiveRecord::Base
  has_many :scope_subcategories
  attr_accessible :name
end
