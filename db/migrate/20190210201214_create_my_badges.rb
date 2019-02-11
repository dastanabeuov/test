class CreateMyBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :my_badges do |t|
      t.belongs_to :badge
      t.belongs_to :user

      t.timestamps
    end
  end
end
