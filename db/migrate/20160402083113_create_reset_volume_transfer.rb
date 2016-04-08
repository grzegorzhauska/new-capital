class CreateResetVolumeTransfer < ActiveRecord::Migration
  def change
    create_table :reset_volume_transfers do |t|
      t.timestamps null: false
    end
  end
end
