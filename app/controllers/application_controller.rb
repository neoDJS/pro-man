class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :current_user
    before_action :set_action_user, only: [:create, :update]
    helper_method :logged_in?

    def current_user
        @user = (User.find_by(id: session[:user_id]) || User.new)
    end

    def logged_in?
        current_user.id != nil
    end

    def require_logged_in
        return redirect_to(controller: 'sessions', action: 'new') unless logged_in?
    end

    def set_action_user
        current_user.set_current_user
    end
end
