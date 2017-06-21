class API::ApplicationController < ApplicationController
  skip_after_action :verify_authorized, :verify_policy_scoped
  before_action :authenticate

  private

  def authenticate
    authenticate_with_http_token do |token|
      @current_user = User.find_by(api_key: token)
    end

    return unless @current_user.nil?

    render json: { error: 'Unauthorized' }, status: 401
  end
end
