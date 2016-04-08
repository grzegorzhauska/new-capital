class Company < ActiveRecord::Base
  has_many :users
  has_many :personal_accounts, through: :users
  has_one :company_account
end
