class AddTitleAndDescriptionToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :title, :string
    add_column :orders, :description, :text
  end
end
