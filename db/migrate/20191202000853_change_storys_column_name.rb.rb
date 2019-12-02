class ChangeStorysColumnName.rb < ActiveRecord::Migration[5.2]
  def change
   rename_column(:storys, :creator_id, :user_id)
  end
end
