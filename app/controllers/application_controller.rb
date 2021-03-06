class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  def verify_user!
    authenticate_user!
    unless current_user.verified?
      flash[:notice] = t('users.profile.phone_number.not_verified')
      redirect_to profile_path
    end
  end
end
