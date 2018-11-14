class CreateWorkshopSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :workshop_steps do |t|
      t.references :workshop, index: true
      t.string :step
      t.boolean :ok, default: false

      t.timestamps
    end
  end
end
