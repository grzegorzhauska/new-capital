class SetCreditLimitForNewAccounts < ActiveRecord::Migration
  def change
    change_column :personal_accounts, :limit, :integer, default: -5000
  end
end
