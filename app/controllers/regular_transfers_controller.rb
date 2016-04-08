class RegularTransfersController < ApplicationController
  before_filter :verify_user!

  expose(:regular_transfer) do
    RegularTransfer.new(transfer_params)
  end

  def create
    if regular_transfer.save
      flash[:notice] = 'Transfer success'
      redirect_to(authenticated_root_path)
    else
      flash[:error] = 'Transfer failed.' + regular_transfer.errors.full_messages.join(', ')
      redirect_to(authenticated_root_path)
    end
  end

  def transfer_params
    params.permit(:to_id, :amount)
      .merge(from_id: current_user.personal_account.id,
             from_type: current_user.personal_account.class,
             to_type: current_user.personal_account.class)
  end
end
