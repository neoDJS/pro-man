class WorkersController < ApplicationController
    before_action :require_logged_in
    before_action :set_worker, only:[:show, :edit, :update]

    def index
      @workers = Worker.all
  
      respond_to do |format|
          if @workers.empty?
              format.html { redirect_to root_path, alert: 'Workers is empty.' }                
          else
              format.html { render :index }
          end
          format.json { render json: @workers, status: :ok }
      end
    end
  
    def show    
      respond_to do |format|
          unless @worker.nil?
              format.html { render :show }         
          else
              format.html { redirect_to workers_path, alert: 'Worker not found.' }
          end
          format.json { render json: @worker, status: :ok }
      end  
    end

    def new
        @worker = Worker.new
        if params[:user_id]
            user = User.find(params[:user_id])
            @worker.build_user(user.as_json)
        else
            @worker.build_user
        end
    end
  
    def create
        @worker = Worker.create(worker_params)

        respond_to do |format|
            if @worker.valid?
                @worker.save
                format.html { redirect_to worker_path(@worker), notice: 'Worker was successfully created.' }
                format.json { render :show, status: :created, location: @worker }                
            else
                format.html { render :new }
                format.json { render json: @worker.errors, status: :unprocessable_entity }
            end
        end
    end
  
    def edit
    end
  
    def update
      @worker.update(worker_params)
        
      respond_to do |format|
          if @worker.save
              format.html { redirect_to worker_path(@worker), notice: 'Worker was successfully updated.' }
              format.json { render :show, status: :created, location: @worker }
          else
              format.html { render :edit }
              format.json { render json: @worker.errors, status: :unprocessable_entity }
          end
      end
    end
  
    private
  
        def worker_params
            params.require(:worker).permit(:title, user_attributes: [:name, :password, :email])
        end

        def set_worker
            @worker = Worker.find(params[:id])
        end
end
