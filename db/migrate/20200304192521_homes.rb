class Homes < ActiveRecord::Migration
  def change
    create_table :homes do |col|
      col.string :name
      col.string :type
      col.string :size
      col.integer :bedrooms
      col.integer :bathrooms
      col.string :location
      col.integer :user_id
    end
  end
end
