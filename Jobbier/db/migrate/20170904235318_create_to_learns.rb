class CreateToLearns < ActiveRecord::Migration[5.0]
  def change
    create_table :to_learns do |t|
      t.references :workshop_category, index: true
      t.references :normal_profile, index: true

      t.timestamps
    end
  end
end
