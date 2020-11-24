class ApplicationController < ActionController::Base
	protect_from_forgery with: :null_session

	include Response
  include ExceptionHandler

  def render_resource(resource)
    if resource.errors.empty?
      @user_response = resource.attributes.merge(profile_photo: resource.photo.attached? ? rails_blob_url(resource.photo) : '')
      json_response(@user_response, '')
    else
      json_error_response(resource.errors, '', :bad_request)
    end
  end
end
