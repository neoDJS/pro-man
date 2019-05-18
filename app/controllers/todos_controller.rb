class TodosController < ApplicationController
    before_action :set_project
    before_action :set_todo, only:[:show, :edit, :update]
    def new
        @todo = project.todos.new
    end

    def create
        @todo = project.todos.new(todo_params)
        if @todo.valid?
            @todo.save
            if todo_users_params
                @todo.affected_to(todo_users_params)
            end
            redirect_to project_todo_path(project, @todo)
        else
            render :new
        end
    end

    def index
        @todos = Todo.all_by_slug(params[:slug])
        if @todos.empty?
            flash[:alert] = "Project not found."
            redirect_to projects_path
        end
    end

    def show    
        unless @todo
            flash[:alert] = "Todo not found."
            redirect_to project_todos_path(project))
        end
    end

    def edit  
        unless @todo
            flash[:alert] = "Todo not found."
            redirect_to project_todos_path(project))
        end
    end

    def update
        @todo.update(todo_params)
        if @todo.save
            if todo_users_params
                @todo.affected_to(todo_users_params)
            end
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
            params.require(:todo).permit(user_ids:[])
        end

        def set_project
            project = Project.find_by_id_or_slug(params[:slug])
        end

        def set_todo
            # project = Project.find_by_id_or_slug(params[:slug])
            @todo = Todo.find_by(project_id: project.id, id: params[:id])
        end
end
