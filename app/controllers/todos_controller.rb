class TodosController < ApplicationController
    before_action :require_logged_in
    before_action :set_project
    before_action :set_todo, only:[:show, :edit, :update, :addUser, :affectation]


    def addUser
        @selected = @todo.affected_users
        @users = User.all
        render :affectation
    end

    def affectation
        if todo_users_params
            @todo.affected_to(todo_users_params)
        end
        redirect_to project_todo_path(@project.slug, @todo)
    end

    def new
        @todo = @project.todos.new
    end

    def create
        @todo = @project.todos.new(todo_params)
        if @todo.valid?
            @todo.save            
            redirect_to project_todo_path(@project.slug, @todo)
        else
            render :new
        end
        # respond_to do |format|
        #     if @comment.save
        #       format.html { redirect_to @comment.post, notice: 'Comment was successfully created.' }
        #       format.js   { }
        #       format.json { render :show, status: :created, location: @comment }
        #     else
        #       format.html { render :new }
        #       format.json { render json: @comment.errors, status: :unprocessable_entity }
        #     end
        # end
    end

    def index
        @todos = @project.todos #Todo.all_by_project_slug(params[:project_slug])
        if @todos.empty?
            flash[:alert] = "Project not found."
            redirect_to projects_path
        end
    end

    def show    
        unless @todo
            flash[:alert] = "Todo not found."
            redirect_to project_todos_path(@project.slug)
        end
    end

    def edit  
        unless @todo
            flash[:alert] = "Todo not found."
            redirect_to project_todos_path(@project.slug)
        end
    end

    def update
        @todo.update(todo_params)
        if @todo.save
            # if todo_users_params
            #     @todo.affected_to(todo_users_params)
            # end
            redirect_to @todo
        else
            # flash[:notice] = "Artist deleted."
            render :edit
        end
    end
    
    private
        def todo_params
            params.require(:todo).permit(:task)
        end

        def todo_users_params
            params.permit(user_ids:[])
        end

        def set_project
            @project = Project.find_by_id_or_slug(params[:project_slug])
        end

        def set_todo
            # project = Project.find_by_id_or_slug(params[:project_slug])
            @todo = Todo.find_by(project_id: @project.id, id: (params[:todo_id]||params[:id]))
        end
end
