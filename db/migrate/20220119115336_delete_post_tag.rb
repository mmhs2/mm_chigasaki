class DeletePostTag < ActiveRecord::Migration[5.2]
  def change
    drop_table :post_tags
  end
end
