class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in @user, :event => :authentication
      redirect_to session[:request_referer]
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    @user = User.find_for_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:success] = "Te logueaste exitosamente con Google"
      sign_in @user
      redirect_to session[:request_referer]
    else
      if @user.errors.any?
        flash[:danger] = @user.errors.messages.map{|k,v| "#{k}: #{v.join(', ')}"}.join('<br>')
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