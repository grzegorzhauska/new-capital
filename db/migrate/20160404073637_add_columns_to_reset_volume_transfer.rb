class AddColumnsToResetVolumeTransfer < ActiveRecord::Migration
  def change
    add_reference :reset_volume_transfers, :personal_account, index: true, foreign_key: true
    add_column :reset_volume_transfers, :before_volume, :integer
  end
end
