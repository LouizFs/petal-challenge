class V1::AuthenticationController < V1::BaseController

   def login
    @user = User.find_by_email(params[:email])

    if @user&.authenticate(params[:password])
      token = ::JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.username }, status: 200
    else
      render json: { error: 'User not found' }, status: 401
    end
  end
end
