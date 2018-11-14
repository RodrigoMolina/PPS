class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :normal_profile, index: true
      t.string :kind
      t.text :content
      t.string :state, default: 'new'

      t.timestamps
    end
  end
end
