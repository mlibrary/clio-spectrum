class CreateScopeJoinTables < ActiveRecord::Migration
  def change
    create_table :scope_databases_scope_quick_sets, id: false do |t|
      t.belongs_to :scope_database, index: true
      t.belongs_to :scope_quick_set, index: true
    end

    create_table :scope_databases_scope_subcategories, id: false do |t|
      t.belongs_to :scope_database, index: true
      t.belongs_to :scope_subcategory, index: true
    end

  end
end