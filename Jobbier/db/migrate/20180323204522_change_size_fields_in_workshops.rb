class ChangeSizeFieldsInWorkshops < ActiveRecord::Migration[5.0]
  def change
    change_column :workshops, :description, :text
  end
end
