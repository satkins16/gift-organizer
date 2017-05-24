class ModifyingGifts < ActiveRecord::Migration[5.1]
  def change
    add_column :gifts, :user_id, :integer
  end
end
