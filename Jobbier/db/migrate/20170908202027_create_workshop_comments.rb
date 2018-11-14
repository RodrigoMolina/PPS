class CreateWorkshopComments < ActiveRecord::Migration[5.0]
  def change
    create_table :workshop_comments do |t|
      t.references :workshop, index: true
      t.references :normal_profile, index: true
      t.text :comment

      t.timestamps
    end
  end
end
