class CreateWorkshopImages < ActiveRecord::Migration[5.0]
  def change
    create_table :workshop_images do |t|
      t.references :workshop, index: true
      t.references :image, index: true
      t.string :kind
      t.timestamps
    end
  end
end
