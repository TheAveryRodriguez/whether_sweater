class User < ApplicationRecord
  validates :email, presence: {message: "Cannot be left blank"}
  validates :email, uniqueness: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates_presence_of :password_digest
  validates :password, confirmation: true, presence: true, on: :create

  has_secure_password

  def self.valid_params?(user_params)
    if user_params[:password] != user_params[:password_confirmation]
      raise ActiveRecord::StatementInvalid, "Passwords don't match, try again."
    else
      true
    end
  end
end
