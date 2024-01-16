class Api::V0::SessionsController < ApplicationController
  def create
    if User.valid_info?(user_params)
      render json: UserSerializer.user_format(User.find_by(email: user_params[:email])), status: 200
    end
  rescue ActiveRecord::StatementInvalid => e
    render json: ErrorSerializer.format_errors(e.message), status: 401
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
