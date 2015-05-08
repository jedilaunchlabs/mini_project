class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :caption
      t.text :description
      t.integer :user_id
      t.boolean :is_draft, default: true
      t.boolean :is_archived, default: false

      t.timestamps null: false
    end
  end
end
