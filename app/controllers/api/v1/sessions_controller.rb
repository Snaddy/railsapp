class Api::V1::SessionsController < Devise::SessionsController
    skip_before_action :verify_signed_out_user, only: [:destroy]
    def create
      user = warden.authenticate!(params[:user])
      sign_in(resource_name, user)

      if current_user.save
        respond_to do |format|
          format.json do
            render json: {
              status: "success",
              email: current_user.email,
              auth_token: current_user.authentication_token,
              user_name: current_user.username
            }
          end
        end
      else
        render json: { status: "error" }
      end
    end

    def destroy
      warden.authenticate!(scope: resource_name, recall: "#{controller_path}#failure")
      current_user.update_column(:authentication_token, nil)
      render json: { success: true,
                      info: "Logged out"}
  end
end