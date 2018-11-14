class CreateWorkshops < ActiveRecord::Migration[5.0]
  def change
    create_table :workshops do |t|

      t.string :name
      t.references :normal_profile
      t.references :workshop_category
      t.references :country
      t.references :province
      t.references :city
      
      t.string   :street
      t.string   :number
      t.string   :floor
      t.string   :apartment
      t.string   :postal_code
      t.text     :observation
      t.float    :latitude
      t.float    :longitude

      t.string :place
      
      t.text :description_place
      t.string :activity_title
      t.string :activity_description
      t.string :gender
      t.integer :age_max, default: 100
      t.integer :age_min, default: 1
      t.string :level
      t.string :description


      t.boolean :offer_material, default: false
      t.string :things_included
      t.string :things_to_carry
      t.string :aspects_to_consider
      t.string :price_unit, default: :por_clase
      t.integer :price_in_cents




      t.boolean :charge_method_transfer, default: false
      t.string :charge_method_transfer_bank
      t.string :charge_method_transfer_subsidiary
      t.string :charge_method_transfer_owner
      t.string :charge_method_transfer_dni
      t.string :charge_method_transfer_account_number
      t.string :charge_method_transfer_cbu
      

      t.string :state, default: 'draft'


      t.timestamps
    end
  end
end
