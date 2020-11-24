class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate(auth_options)
    if resource.present?
      render_resource(resource)
    else
      json_error_response('Invalid Email or password.', '', :bad_request)
    end
  end

  private

  def respond_to_on_destroy
    head :no_content
  end

end
