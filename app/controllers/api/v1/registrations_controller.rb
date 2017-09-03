class Api::V1::RegistrationsController < Devise::RegistrationsController

 skip_before_action :authenticate_scope!, :only => [:update]
 before_action :authenticate_user!, :only => [:update]

    def create
      @user = User.create(user_params)
      if @user.save
        sign_in(@user)
        render json: { status: "created",
                      info: "Registered",
                      auth_token: current_user.authentication_token,
                      email: current_user.email,
                      user_name: current_user.username,
                      data: { user: resource }}
      else
        render json: { status: "error" }
      end
    end

    def update
      @user = current_user
        if @user.update(user_params)
          render json: { result: "success"}
        else
          render json: { result: "error"}
        end
    end

    private

    def user_params
      params.permit(:email, :username, :name, :password, :bio, :avatar, :gender)
    end

    def update_params
      params.permit(:email, :username, :name, :bio, :avatar, :gender)
    end

end
