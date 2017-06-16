class API::ApplicationController < ApplicationController
  before_action :authenticate

  private
    def authenticate
      authenticate_with_http_token do |token|
        @current_user = User.find_by(api_key: token)
      end

      if @current_user.nil?
        render json: { error: "Unauthorized" }, status: 401
        return
      end
    end
end
