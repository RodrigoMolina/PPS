class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :surname
      t.references :user, index: true      
      t.references :image, index: true
      t.date :birthdate
      t.string :dni
      t.string :type
      t.string :gender
      
      t.string :phone_country
      t.string :phone_area
      t.string :phone_number
      t.string :phone_activation_code


      t.string :preference_place
      t.string :preference_assistance
      t.string :preference_time

      t.references :country
      t.references :province
      t.references :city
      t.string   :postal_code
      t.string   :street
      t.string   :number
      t.string   :floor
      t.string   :apartment

      t.text :observation
      
      t.timestamps
    end
  end
end
