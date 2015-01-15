class CreateScopeQuickSets < ActiveRecord::Migration
  def change
    create_table :scope_quick_sets do |t|
      t.string :name

      t.timestamps
    end
  end
end
