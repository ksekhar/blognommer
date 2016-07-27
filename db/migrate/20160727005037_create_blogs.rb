class CreateBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :blogs do |t|
      t.string :name, null:  false
      t.string :slug, null: false
      t.boolean :active, default: true
      t.integer :visitors
      t.references :user

      t.timestamps
    end
    add_index :blogs, :slug, unique: true
  end
end
