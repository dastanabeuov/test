class AddColumToBadges < ActiveRecord::Migration[5.2]
  def change
    add_column :badges, :primary_param, :string
    add_column :badges, :secondary_param, :string
  end
end
