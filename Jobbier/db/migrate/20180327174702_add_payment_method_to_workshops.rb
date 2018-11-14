class AddPaymentMethodToWorkshops < ActiveRecord::Migration[5.0]
  def change
    add_column :workshops, :payment_method, :string
  end
end
