class Api::V1::RegistrationsController < Devise::RegistrationsController

skip_before_action :authenticate_scope!, :only => [:update]

    def create
      @user = User.create(user_params)
      if @user.save
        sign_in(@user)
        render json: { status: "created",
                      info: "Registered",
                      auth_token: current_user.authentication_token,
                      email: current_user.email,
                      data: { user: resource }}
      else
        render json: { status: @user.errors.full_messages }
      end
    end

    def update
      @user = current_user
      if @user.valid_password?(user_params[:password])
        if @user.update(user_params)
          render json: { result: "success"}
        else
          render json: { result: "error"}
        end
      else
        render json: { result: "invalid"}
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :username, :name, :password, :bio)
    end

end
