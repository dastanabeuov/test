class Badges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.string :image
      t.string :rule, null: false
      t.string :primary_param

      t.timestamp
    end  	
  end
end
