class RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters, if: :devise_controller?

  def new
    self.resource = User.new(normal_profile: NormalProfile.new)
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_email    = edit_user_registration_path
    
    resource.email if resource.respond_to?(:email)

    resource_updated = update_resource(resource, account_update_params)

    yield resource if block_given?
    
    if resource_updated
      flash[:success] = t(:success)
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      flash[:danger] = t(:error)
      clean_up_passwords resource
      render :edit
    end
  end

  def update_resource(resource, params)
      resource.update_without_password(params)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [normal_profile_attributes: [:postal_code, :street, :number, :floor, :apartment, :birthdate, :dni, :name, :surname, :gender, :id, :country_id, :province_id, :city_id, :phone_country, :phone_area, :phone_number, :phone_activation_code, :observation, :preference_place, :preference_assistance, :preference_time, image_attributes: [:file, :file_cache, :_destroy, :id], workshop_category_to_teach_ids: [], workshop_category_to_learn_ids: []]])
    devise_parameter_sanitizer.permit(:account_update, keys: [admin_profile_attributes: [:postal_code, :street, :number, :floor, :apartment, :birthdate, :dni, :name, :surname, :gender, :id, :country_id, :province_id, :city_id, :phone_country, :phone_area, :phone_number, :phone_activation_code, :observation, :preference_place, :preference_assistance, :preference_time, image_attributes: [:file, :file_cache, :_destroy, :id], workshop_category_to_teach_ids: [], workshop_category_to_learn_ids: []],
                                                             normal_profile_attributes: [:postal_code, :street, :number, :floor, :apartment, :birthdate, :dni, :name, :surname, :gender, :id, :country_id, :province_id, :city_id, :phone_country, :phone_area, :phone_number, :phone_activation_code, :observation, :preference_place, :preference_assistance, :preference_time, image_attributes: [:file, :file_cache, :_destroy, :id], workshop_category_to_teach_ids: [], workshop_category_to_learn_ids: []]])
  end

  def after_update_path_for(resource)
    root_path
  end
  
end