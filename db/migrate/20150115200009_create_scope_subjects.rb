class CreateScopeSubjects < ActiveRecord::Migration
  def change
    create_table :scope_subjects do |t|
      t.string :name

      t.timestamps
    end
  end
end
