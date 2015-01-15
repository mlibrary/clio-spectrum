class CreateScopeDatabaseTypes < ActiveRecord::Migration
  def change
    create_table :scope_database_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
