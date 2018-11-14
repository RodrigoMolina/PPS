class CreateWorkshopFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :workshop_favorites do |t|
      t.references :workshop, index: true
      t.references :normal_profile, index: true

      t.timestamps
    end
  end
end
