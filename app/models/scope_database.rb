class ScopeDatabase < ActiveRecord::Base
  has_and_belongs_to_many :scope_quick_sets
  has_and_belongs_to_many :scope_subcategories

  attr_accessible :description, :name

  default_scope order('name ASC')

end
