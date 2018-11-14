class ConfirmationsController < Devise::ConfirmationsController
  def show
  	super
  end

  protected
  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource)
    root_path
  end
end