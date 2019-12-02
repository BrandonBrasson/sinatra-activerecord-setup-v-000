class CreateUserStory < ActiveRecord::Migration[5.2]
  def change
    create_table :user_storys do |t|
          t.integer :user_id
          t.integer :story_id
  end
end
