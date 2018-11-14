class SessionsController < Devise::SessionsController

  rescue_from ActionController::InvalidAuthenticityToken, with: :warn_session_reset

  

  def new
    session[:request_referer] = request.referer
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    #respond_with(resource, serialize_options(resource))
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /resource/sign_in
  def create

    resource = User.find_for_database_authentication(email: params[:user][:email])

    if resource
      if resource.valid_password?(params[:user][:password])
        sign_in :user, resource
        flash[:success] = t('devise.sessions.signed_in')
        session[:inscript] = params[:inscript]
        respond_to do |format|
          format.html { redirect_to session[:request_referer] }
          format.js
        end
      else
        #flash[:danger] = 'Contraseña invalida'
        self.resource = resource
        self.resource.errors.add(:password, 'Contraseña invalida')
        render :new
      end
    else
      self.resource = resource_class.new(sign_in_params)

      if params[:user][:email].blank?
        self.resource.errors.add(:email, 'Ingrese correo')
      end

      if params[:user][:password].blank?
        self.resource.errors.add(:password, 'Ingrese contraseña')
      end
      
      if params[:user][:email].present?
        self.resource.errors.add(:email, 'Usuario inexistente')
      end

      #flash[:danger] = 'Usuario inexistente'
      clean_up_passwords(resource)
      render :new
    end

  end



  private

  def warn_session_reset
    redirect_back(
      fallback_location: root_path,
      alert: 'Su sesion ha expirado, por favor intente loguearse nuevamente.'
    )
  end


end









