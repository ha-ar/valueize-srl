class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    debugger
    build_resource(sign_up_params)
    if resource.save
      sign_in(resource_name, resource)
      render_resource(resource)
    else
      json_error_response(resource.errors.full_messages, '', :unprocessable_entity)
    end
  end

  protected

  def sign_up_params
    params
      .require(:user)
      .permit(
        :email, :password, :password_confirmation, :name, :surname, :role, :photo
      )
  end
  
end
