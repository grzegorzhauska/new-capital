class CreateTransferHistory < ActiveRecord::Migration
  def change
    create_table :transfer_histories do |t|
      t.string :transfer_type
      t.integer :transfer_id
      t.references :transfer_history

      t.timestamps null: false
    end
  end
end
