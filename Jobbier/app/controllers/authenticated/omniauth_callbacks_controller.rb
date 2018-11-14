class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    @user = User.find_for_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      set_flash_message(:notice, :success, "Verifica tu email") if is_navigational_format?
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
      sign_in_and_redirect @user
    else
      if @user.errors.any?
        flash[:danger] = @user.errors.messages.collect{|k,v| "#{k}: #{v.join(', ')}"}.join('<br>')
      else
        flash[:danger] = t(:error)
      end
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end
end