class AddIageIdToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :image_id, :string
  end
end
