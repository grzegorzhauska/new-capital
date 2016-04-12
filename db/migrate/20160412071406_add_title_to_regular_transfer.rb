class AddTitleToRegularTransfer < ActiveRecord::Migration
  def change
    add_column :regular_transfers, :title, :string
  end
end
