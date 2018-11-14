class CreateWorkshopSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :workshop_schedules do |t|
      t.references :workshop, index: true
      t.text :schedule_info

      t.integer :maximun_quota, default: 0
      t.integer :actual_quota, default: 0
      t.boolean :unlimited_quota, default: false
      t.date :start_publication
      t.boolean :always_open, default: false
      t.date :closing_of_registrations
      t.boolean :never_close, default: false
      t.integer :lock_version, default: 0

      t.timestamps
    end
  end
end
