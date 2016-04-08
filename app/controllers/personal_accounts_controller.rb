class PersonalAccountsController < ApplicationController
  before_action :authenticate_user!

  def show
    @personal_account = current_user.personal_account
  end
end
