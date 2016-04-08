class CompanyAccount < ActiveRecord::Base
  belongs_to :company
  has_many :personal_accounts

  def limiting_function(amount)
    amount
  end
end
