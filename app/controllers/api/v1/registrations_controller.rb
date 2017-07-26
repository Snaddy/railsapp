class Api::V1::RegistrationsController < Devise::RegistrationsController

before_filter :authenticate_user!

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
      if @user.update(user_params)
        render json: "success"
      else
        render json: "failed"
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :username, :name, :password, :bio)
    end

end
