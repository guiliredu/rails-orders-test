class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.string :control_number
      t.integer :state

      t.timestamps
    end
  end
end
