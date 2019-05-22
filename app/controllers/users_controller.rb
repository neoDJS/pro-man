class UsersController < ApplicationController
  before_action :require_logged_in, only:[:show, :edit, :update]

  def new
  end

  def create
    @user = User.create(user_params)
    # return redirect_to controller: 'users', action: 'new' unless @user.save
    if @user.save
      @user.set_current_user
      session[:user_id] = @user.id
      redirect_to controller: 'projects', action: 'index'
    else
      render :new
    end
  end

  def edit
  end

  def update    
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to @user
    else
        # flash[:notice] = "Artist deleted."
        render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :email)
    end
end
