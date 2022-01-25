class AddPlaceIdToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :place_id, :integer
  end
end
