class UsersController < ApplicationController
  def get_user
  	json_response(current_user.attributes.merge(photo: current_user.photo.attached? ? rails_blob_url(current_user.photo) : ''), 'get login user')
  end
end
