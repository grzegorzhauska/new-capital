class CompeniesUsers < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
end
