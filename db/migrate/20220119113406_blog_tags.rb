class BlogTags < ActiveRecord::Migration[5.2]
  def change
    drop_table :blog_tags
  end
end
