class ModifyingGivers < ActiveRecord::Migration[5.1]
  def change
    add_column :givers, :user_id, :integer
  end
end
