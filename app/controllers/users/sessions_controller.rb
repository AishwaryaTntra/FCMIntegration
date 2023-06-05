# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include ApiResponder
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:user][:email])

    if user && user.valid_password?(sign_in_params[:password])
      # resource.update_column(:jti, SecureRandom.uuid)
      sign_in(User, user)
      render_success({ user: serialized_json(user) }.merge(logged_out: true), 'User signed in successfully.')
    else
      render json: error_json('Failed to login'), status: 401
    end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    if signed_out
      render_success({ user: serialized_json(resource) }.merge(logged_out: true),'Signed out successfully.')
    else
      render_error('Failed to sign out.')
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def serialized_json(details)
    UserSerializer.new(details).serializable_hash[:data]
  end

  def verify_signed_out_user
    render_success({ user: serialized_json(resource) }, t('devise.sessions.signed_out')) if all_signed_out?
  end
end
