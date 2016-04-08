require 'rails_helper'

RSpec.describe TheAccount, type: :model do
  describe 'system actions' do
    let(:the_account) { create(:the_account) }
    let(:account) { create(:personal_account, balance: 100) }
    let(:account_2) { create(:personal_account, balance: 10) }

    it 'gesells' do
      the_account
      account
      account_2

      the_account.gesell

      expect(account.reload.balance).to eq 99
      expect(account_2.reload.balance).to eq 9
      expect(the_account.reload.balance).to eq 2
    end

    it 'douglas' do
      the_account.update_column(:balance, 100)
      account
      account_2

      the_account.douglas

      expect(account.reload.balance).to eq 150
      expect(account_2.reload.balance).to eq 60
      expect(the_account.reload.balance).to eq 0
    end

    it 'volume reset' do
      the_account
      account.update_column(:volume, 100)
      account_2.update_column(:volume, 100000)

      the_account.volume_reset

      expect(account.reload.volume).to eq 0
      expect(account_2.reload.volume).to eq 0
    end
  end
end
