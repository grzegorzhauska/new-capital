class RegularTransfer < ActiveRecord::Base
  belongs_to :from, polymorphic: true
  belongs_to :to, polymorphic: true
  has_one :transfer_history, as: :transfer

  validates :from, :to, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validate :different_accounts?

  before_create :transfer
  after_create :create_transfer_history

  def different_accounts?
    if from == to
      errors.add(:from, :same_accounts)
      errors.add(:to, :same_accounts)
    end
  end

  def transfer
    from_transfer && to_transfer
  end

  def from_transfer
    from.balance -= amount
    from.save
  end

  def to_transfer
    self.after_tax = to.limiting_function(amount)
    self.before_volume = to.volume
    to.volume += amount
    to.balance += self.after_tax
    to.save
  end

end
