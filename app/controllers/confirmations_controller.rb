class ConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for(resource_name, resource)
    redirect_to 'devise/confirmations/confirmed'
  end
end