class CreateWorkshopCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :workshop_categories do |t|
      t.string :name
      t.references :image_cover, index: true
      t.references :image_card_category, index: true
      t.timestamps
    end
  end
end
