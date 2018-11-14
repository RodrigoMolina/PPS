class CreateWorkshopScheduleSubscribeds < ActiveRecord::Migration[5.0]
  def change
    create_table :workshop_schedule_subscribeds do |t|
      t.references :workshop_schedule, index: true
      t.references :normal_profile, index: true

      t.timestamps
    end
  end
end
