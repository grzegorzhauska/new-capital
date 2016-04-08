class ProfilesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @profile = current_user
  end

  def edit
    @profile = current_user
  end

  def update
    @profile = current_user
    if @profile.update_attributes(profile_params)
      sign_in 'user', @profile, bypass: true
      flash[:notice] = t('users.profile.edit.updated')
      redirect_to action: :show
    else
      render action: :edit
    end
  end

  def phone_number_code_verify
    current_user.phone_number_verify!(params[:phone_number_code])
    # render status: 200, json: "Phone number verified."
    # render status: 422, json: "Wrong code"
    redirect_to action: :show
  end

  def send_verification_code
    current_user.send_verification_code
    redirect_to action: :show
  end

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :phone_number)
  end
end
