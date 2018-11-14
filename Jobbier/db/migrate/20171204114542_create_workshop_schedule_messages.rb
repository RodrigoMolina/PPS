class CreateWorkshopScheduleMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :workshop_schedule_messages do |t|
      t.text :body
      t.references :workshop_schedule, index: true
      t.references :profile, index: true

      t.timestamps
    end
  end
end
