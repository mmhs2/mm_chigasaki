class DropCategory < ActiveRecord::Migration[5.2]
  def change
    remove_column :blogs, :category
  end
end
