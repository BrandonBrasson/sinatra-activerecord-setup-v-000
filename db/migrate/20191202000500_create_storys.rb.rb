class CreateStorys.rb < ActiveRecord::Migration[5.2]
  def change
    create_table :storys do |t|
          t.string :name
          t.string :url
  end
end
