class CreateScopeDatabases < ActiveRecord::Migration
  def change
    create_table :scope_databases do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
