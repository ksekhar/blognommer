class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.references :user
      t.references :blog
      t.text :content, null: false
      t.boolean :published, default: false
      t.integer :views

      t.timestamps
    end
    add_index :posts, :slug, unique: true
  end
end
