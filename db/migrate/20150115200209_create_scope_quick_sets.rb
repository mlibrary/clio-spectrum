class CreateScopeQuickSets < ActiveRecord::Migration
  def change
    create_table :scope_quick_sets do |t|
      t.string :name, null: false
      t.string :description, default: ''
      t.boolean :suppressed, default: true

      t.timestamps
    end
  end
end
