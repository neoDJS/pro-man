class UsersController < ApplicationController
  before_action :require_logged_in, only:[:show, :edit, :update]
  skip_before_action :set_action_user, only: [:create]

  def index
    @users = User.all

    respond_to do |format|
        if @users.empty?
            format.html { redirect_to root_path, alert: 'Users is empty.' }                
        else
            format.html { render :index }
        end
        format.json { render json: @users, status: :ok }
    end
  end

  def show    
    @user = User.find(params[:id])
    respond_to do |format|
        unless @user.nil?
            format.html { render :show }         
        else
            format.html { redirect_to users_path, alert: 'User not found.' }
        end
        format.json { render json: @user, status: :ok }
    end  
  end

  def new
  end

  def create
    @user = User.create(user_params)
    # return redirect_to controller: 'users', action: 'new' unless @user.save

    respond_to do |format|
      if @user.valid?
          @user.save
          # @user.set_current_user
          session[:user_id] = @user.id
          format.html { redirect_to projects_path(@project), notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }                
      else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit  
    @user = User.find(params[:id])
  end

  def update    
    @user = User.find(params[:id])
    @user.update(user_params)

    respond_to do |format|
      if @user.save
          format.html { redirect_to user_path(@user), notice: 'User was successfully updated.' }
          format.json { render :show, status: :created, location: @user }
      else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :email)
    end
end
