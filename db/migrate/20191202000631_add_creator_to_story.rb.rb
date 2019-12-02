class AddCreatorToStory.rb < ActiveRecord::Migration[5.2]
  def change
add_column :storys, :creator_id, :integer
  end
end
