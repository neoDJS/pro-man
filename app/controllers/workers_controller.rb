class WorkersController < ApplicationController
    before_action :require_logged_in
    before_action :set_worker, only:[:show, :edit, :update]

    def new
        @worker = Worker.new
    end
  
    def create
      @user = User.create(user_params)
      if @user.save
        @worker = user.build_worker(worker_params)
        
        if @worker.save
            redirect_to @worker
        else
            render :new
        end
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      @worker.update(worker_params)
      if @worker.save
        redirect_to @worker
      else
          # flash[:notice] = "Artist deleted."
          render :edit
      end
    end
  
    private
  
        def worker_params
            params.require(:worker).permit(:task)
        end

        def user_params
            params.require(:worker).permit(:name, :password, :email)
        end

        def set_worker
            @worker = Worker.find(params[:id])
        end
end
