module Response
  def json_response(object, message = "", status)
    response = {
      success: true,
      status: :ok,
      message: message,
      data: object
    }
    render json: response, status: :ok
  end

  def json_error_response(errors, message, status)
    response = {
      success: false,
      status: :ok,
      message: message,
      errors: errors
    }

    render json: response, status: :ok
  end
end
