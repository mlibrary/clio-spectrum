class CreateScopeJoinTables < ActiveRecord::Migration
  def change
    create_table :scope_databases_scope_quickesets, id: false do |t|
      t.belongs_to :scope_database, index: true
      t.belongs_to :scope_quickset, index: true
    end

    create_table :scope_databases_scope_subcategories, id: false do |t|
      t.belongs_to :scope_database, index: true
      t.belongs_to :scope_subcategory, index: true
    end

  end
end