class DouglasTransfer < ActiveRecord::Base
  has_one :transfer_history, as: :transfer
  belongs_to :to, polymorphic: true

  validates :to, :amount, presence: true

  before_create :transfer
  after_create :create_transfer_history

  def self.transfer
    the_account = TheAccount.first
    c = PersonalAccount.count
    single_amount = the_account.balance / c

    PersonalAccount.all.each do |a|
      create(to: a, amount: single_amount)
    end
    [c, single_amount]
  end

  def from_id
    nil
  end

  def after_tax
    nil
  end

  def transfer
    from_transfer && to_transfer
  end

  def from_transfer
    the_account = TheAccount.first
    the_account.balance -= amount
    the_account.save
  end

  def to_transfer
    to.balance += amount
    to.save
  end
end
