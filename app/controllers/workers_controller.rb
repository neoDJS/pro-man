class WorkersController < ApplicationController
    before_action :require_logged_in
    before_action :set_worker, only:[:show, :edit, :update]

    def new
        @worker = Worker.new
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
