class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.string :file
      t.string :type
      t.timestamps null: false
    end
  end
end
