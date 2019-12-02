class ChangeUserStorysToBookmarks.rb < ActiveRecord::Migration[5.2]
  def change
rename_table('user_storys', 'bookmarks')
  end
end
