class V1::BaseController < ::ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: { error: "Record not found"}, status: 404
  end

  def authenticate
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = ::JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      render json: { error: "Invalid token" }, status: 401
    end
  end
end
