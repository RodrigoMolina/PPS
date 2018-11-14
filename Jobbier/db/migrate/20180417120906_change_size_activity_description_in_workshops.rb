class ChangeSizeActivityDescriptionInWorkshops < ActiveRecord::Migration[5.0]
  def change
    change_column :workshops, :activity_description, :text    
  end
end
