class FixPolymorphicGesellDouglas < ActiveRecord::Migration
  def change
    add_column :gesell_transfers, :from_type, :string
    add_column :douglas_transfers, :to_type, :string
  end
end
