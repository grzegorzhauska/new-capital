class GesellTransfer < ActiveRecord::Base
  has_one :transfer_history, as: :transfer
  belongs_to :from, polymorphic: true

  validates :from, :amount, presence: true

  before_create :transfer
  after_create :create_transfer_history

  def self.transfer
    amount = 0
    PersonalAccount.all.each do |a|
      if a.balance > 0
        one_percent = a.balance / 100
        final = one_percent > 0 ? one_percent : 1
        amount += final
        create(from: a, amount: final)
      else
        create(from: a, amount: 0)
      end
    end
    amount
  end

  def to_id
    nil
  end

  def title
    nil
  end

  def after_tax
    nil
  end

  def transfer
    from_transfer && to_transfer
  end

  def from_transfer
    from.balance -= amount
    from.save
  end

  def to_transfer
    the_account = TheAccount.first
    the_account.balance += amount
    the_account.save
  end
end
