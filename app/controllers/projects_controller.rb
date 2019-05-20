class ProjectsController < ApplicationController
    before_action :require_logged_in
    before_action :set_project, only:[:show, :edit, :update]

    def index
        @projects = Project.all
    end

    def new
        @project = Project.new
    end

    def create
        @project = Project.create(project_params)
        redirect_to project_path(@project)
    end

    def show
        @project = Project.find_by_id_or_slug(params[:slug])
    end

    def edit
    end

    def update
        @project.update(project_params)
        redirect_to project_path(@project)
    end
    
    private
        def project_params
            params.require(:project).permit(:name, :description, :priority)
        end

        def set_project
            @project = Project.find_by_id_or_slug(params[:slug])
        end
end
