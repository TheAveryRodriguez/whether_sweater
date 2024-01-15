class Api::V0::UsersController < ApplicationController
  def create
    if User.valid_params?(params)
      user = User.create!(user_params.merge(api_key: api_generator))
      render json: UserSerializer.user_format(user), status: 201
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: ErrorSerializer.format_errors(e.message), status: 409
  rescue ActiveRecord::StatementInvalid => e
    render json: ErrorSerializer.format_errors(e.message), status: 404
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def api_generator
    SecureRandom.hex(21)
  end
end
