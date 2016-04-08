class TransferHistory < ActiveRecord::Base
  belongs_to :transfer, polymorphic: true
  belongs_to :regular_transfer,
             -> do
                where(transfer_histories: {transfer_type: 'RegularTransfer'})
             end,
             foreign_key: 'transfer_id'
  belongs_to :douglas_transfer,
             -> do
                where(transfer_histories: {transfer_type: 'DouglasTransfer'})
             end,
             foreign_key: 'transfer_id'
  belongs_to :gesell_transfer,
             -> do
                where(transfer_histories: {transfer_type: 'GesellTransfer'})
             end,
             foreign_key: 'transfer_id'
  belongs_to :reset_volume_transfer,
             -> do
                where(transfer_histories: {transfer_type: 'ResetVolumeTransfer'})
             end,
             foreign_key: 'transfer_id'

  def self.transfers(account)
    TransferHistory
      .includes(:regular_transfer,
                :douglas_transfer,
                :gesell_transfer,
                :reset_volume_transfer)
      .references(:regular_transfer,
                  :douglas_transfer,
                  :gesell_transfer,
                  :reset_volume_transfer)
      .where(" ((regular_transfers.to_id = ? "\
             "   AND regular_transfers.to_type = ?) "\
             "    OR (regular_transfers.from_id = ? "\
             "   AND regular_transfers.from_type = ?)) "\
             " OR regular_transfers.id is NULL",
             account.id, account.class, account.id, account.class)
      .where(" (douglas_transfers.to_id = ? "\
             "  AND douglas_transfers.to_type = ?) "\
             " OR douglas_transfers.id is NULL",
             account.id, account.class)
      .where(" (gesell_transfers.from_id = ? "\
             "  AND gesell_transfers.from_type = ?) "\
             " OR gesell_transfers.id is NULL",
             account.id, account.class)
      .where(" reset_volume_transfers.personal_account_id = ? "\
             " OR reset_volume_transfers.id is NULL",
             account.id)
      .order(created_at: :desc)
  end

  def transfer
    case transfer_type
    when 'RegularTransfer'
      regular_transfer
    when 'DouglasTransfer'
      douglas_transfer
    when 'GesellTransfer'
      gesell_transfer
    when 'ResetVolumeTransfer'
      reset_volume_transfer
    else
      super
    end
  end
end
