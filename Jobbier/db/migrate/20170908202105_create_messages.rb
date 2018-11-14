class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :source_profile, index: true
      t.references :destination_profile, index: true
      t.text :body

      t.timestamps
    end
  end
end
