class PersonalAccount < ActiveRecord::Base
  belongs_to :user
  has_many :to_transfers, as: :to
  has_many :from_transfers, as: :from

  validate :valid_balance

  def transfers
    RegularTransfer.where("(to_id = ? AND to_type = ?) OR"\
                          "(from_id = ? AND from_type = ?)",
                          self.id, self.class, self.id, self.class)
  end

  def valid_balance
    errors.add(:balance,
               :limit_crossed) if balance < limit
  end

  def can_withdraw?(amount)
    (balance - amount) > limit
  end

  def transfer(other_account, amount)
    RegularTransfer.create(from: self, to: other_account, amount: amount)
  end

  def limiting_function(amount)
    case
    when volume + amount <= 30000
      amount
    when volume < 30000
      a = 30000 - volume
      amount_over = amount - a
      b = amount_over / 10

      the_account = TheAccount.first
      the_account.update_column(:balance, the_account.balance + amount_over - b)

      a + b
    when volume >= 30000
      c = amount / 10

      the_account = TheAccount.first
      the_account.update_column(:balance, the_account.balance + amount - c)

      c
    end
  end
end
