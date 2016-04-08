class ResetVolumeTransfer < ActiveRecord::Base
  has_one :transfer_history, as: :transfer
  belongs_to :personal_account

  validates :personal_account, presence: true

  before_create :transfer
  after_create :create_transfer_history

  def self.transfer
    PersonalAccount.all.each do |pa|
      create(personal_account: pa)
    end
  end

  def from_id
    nil
  end

  def to_id
    nil
  end

  def after_tax
    nil
  end

  def amount
    nil
  end

  def transfer
    self.before_volume = personal_account.volume
    personal_account.volume = 0
    personal_account.save
  end
end
