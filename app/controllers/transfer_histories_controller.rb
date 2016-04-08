class TransferHistoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @transfer_histories =
      TransferHistory
      .transfers(current_user.personal_account)
  end

  def transfer_params
    params.permit(:to_id, :amount)
      .merge(from_id: current_user.personal_account.id)
  end
end
