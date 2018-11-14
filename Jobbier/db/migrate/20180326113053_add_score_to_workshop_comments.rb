class AddScoreToWorkshopComments < ActiveRecord::Migration[5.0]
  def change
    add_column :workshop_comments, :score, :integer, default: 1
  end
end
