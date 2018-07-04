class AuthenticationAdminController < ApplicationController
    protect_from_forgery with: :null_session
    def authenticate_admin
      admin = Admin.find_for_database_authentication(email: params[:email])
      if admin.valid_password?(params[:password])
        render json: payload(admin)
      else
        render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
      end
    end
  
    private
  
    def payload(admin)
      return nil unless admin and admin.id
      {
        auth_token: JsonWebToken.encode({admin_id: admin.id}),
        admin: {id: admin.id, email: admin.email}
      }
    end
  end