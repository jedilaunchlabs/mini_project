class CreateBlogsCategories < ActiveRecord::Migration
  def change
    create_table :blogs_categories do |t|
      t.integer :category_id
      t.integer :blog_id

      t.timestamps null: false
    end
  end
end
