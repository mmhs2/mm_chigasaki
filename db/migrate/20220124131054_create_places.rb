class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.text :name, null: false

      t.timestamps
    end
  end
end
