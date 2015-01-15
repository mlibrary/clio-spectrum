class CreateScopeSubcategories < ActiveRecord::Migration
  def change
    create_table :scope_subcategories do |t|
      t.string :name

      t.timestamps
    end
  end
end
