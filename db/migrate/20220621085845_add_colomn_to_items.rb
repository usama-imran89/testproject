class AddColomnToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :retire, :bool
    add_column :items, :quantity, :integer
  end
end
