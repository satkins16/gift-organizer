class ModifyGifts < ActiveRecord::Migration[5.1]
  def change
    add_column :gifts, :event_id, :integer
  end
end
