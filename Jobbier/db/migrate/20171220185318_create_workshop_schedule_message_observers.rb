class CreateWorkshopScheduleMessageObservers < ActiveRecord::Migration[5.0]
  def change
    create_table :workshop_schedule_message_observers do |t|
      t.references :workshop_schedule_message, index: {:name => "workshop_schedule_message"}
      t.references :profile, index: {:name => "profile"}
      t.string :state, default: :new
      t.string :kind

      t.timestamps
    end
  end
end
