class ProjectsController < ApplicationController
    before_action :require_logged_in
    before_action :set_project, only:[:show, :edit, :update]

    def index
        @projects = Project.all

        respond_to do |format|
            msg = ''
            if @projects.empty?
                msg = 'There is no Projects found.'
            end
            format.html { render :index, alert: msg }
            format.json { render json: @projects, status: :ok }
        end
    end

    def new
        @project = Project.new

        respond_to do |format|
            format.html { render :new }
            format.json { render json: @project, status: :ok }
        end
    end

    def create
        @project = Project.create(project_params)

        respond_to do |format|
            if @project.valid?
                @project.save
                format.html { redirect_to project_path(@project), notice: 'Project was successfully created.' }
                format.json { render :show, status: :created, location: @project }                
            else
                format.html { render :new }
                format.json { render json: @project.errors, status: :unprocessable_entity }
            end
        end
    end

    def show
        # @project = Project.find_by_id_or_slug(params[:slug])
        respond_to do |format|
            unless @project.nil?
                format.html { render :show }           
            else
                format.html { redirect_to projects_path, alert: 'Project not found.' }  
            end
            format.json { render json: @project, status: :ok }
        end  
    end

    def edit
        respond_to do |format|
            unless @project.nil?
                format.html { render :edit }   
            else
                format.html { redirect_to projects_path, alert: 'Project not found.' }
            end
            format.json { render json: @project, status: :ok }
        end 
    end

    def update
        @project.update(project_params)
        
        respond_to do |format|
            if @project.save
                format.html { redirect_to project_path(@project), notice: 'Project was successfully updated.' }
                format.json { render :show, status: :created, location: @project }
            else
                format.html { render :edit }
                format.json { render json: @project.errors, status: :unprocessable_entity }
            end
        end
    end
    
    private
        def project_params
            params.require(:project).permit(:name, :description, :priority)
        end

        def set_project
            @project = Project.find_by_id_or_slug(params[:slug])
        end
end
