class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_profile, :type_admin?, :type_normal?, :profile_root_url
  before_action :get_notifications

  def get_notifications
    if (current_profile.present?)
      @profile_notifications = current_profile.notifications.filter_new
    else
      @profile_notifications = []
    end
  end

  #-----------------------------------------------------------------------
  # Helpers para saber de que tipo es el usuario
  def type_admin?
    current_profile.type_admin? if (current_profile.present?)
  end

  def type_normal?
    current_profile.type_normal? if (current_profile.present?)
  end


  def current_profile
    current_user.profile if (current_user.present?)
  end

end
