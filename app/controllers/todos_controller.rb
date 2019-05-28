class TodosController < ApplicationController
    before_action :require_logged_in
    before_action :set_project
    before_action :set_todo, only:[:show, :edit, :update, :addWorker, :affectation]
    before_action :set_action_user, only: [:affectation]


    def addWorker
        @selected = @todo.workers
        @workers = Worker.all

        respond_to do |format|
            format.html { render :affectation }
            format.json { render json: {todo: @todo, workers: @workers}, status: :ok }
        end
    end

    def affectation
        puts "affect todo"
        puts todo_workers_params.inspect
        if todo_workers_params
            @todo.affected_to(todo_workers_params)
        end

        respond_to do |format|
            format.html { redirect_to project_todo_path(@project.slug, @todo) }
            format.json { render json: @todo, status: :ok }
        end
    end

    def new
        @todo = @project.todos.new
        
        respond_to do |format|
            format.html { render :new }
            format.json { render json: @todo, status: :ok }
        end
    end

    def create
        @todo = @project.todos.new(todo_params)
        respond_to do |format|
            if @todo.valid?
                @todo.save
                format.html { redirect_to project_path(@project.slug), notice: 'Todo was successfully created.' }
                format.json { render :show, status: :created, location: @todo }                
            else
                format.html { render :new }
                format.json { render json: @todo.errors, status: :unprocessable_entity }
            end
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

        respond_to do |format|
            if @todos.empty?
                format.html { redirect_to project_path(@project.slug), alert: 'Todos not found.' }                
            else
                format.html { render :index }
            end
            format.json { render json: @todos, status: :ok }
        end
    end

    def show  
        respond_to do |format|
            unless @todo.nil?
                format.html { render :show }         
            else
                format.html { redirect_to project_todos_path(@project.slug), alert: 'Todo not found.' }
            end
            format.json { render json: @todo, status: :ok }
        end  
    end

    def edit 
        respond_to do |format|
            unless @todo.nil?
                format.html { render :edit }             
            else
                format.html { redirect_to project_todos_path(@project.slug), alert: 'Todo not found.' }
            end
            format.json { render json: @todo, status: :ok }
        end 
    end

    def update
        @todo.update(todo_params)
        respond_to do |format|
            if @todo.save
                format.html { redirect_to project_todo_path(@project.slug, @todo), notice: 'Todo was successfully updated.' }
                format.json { render :show, status: :created, location: @todo }
            else
                format.html { render :edit }
                format.json { render json: @todo.errors, status: :unprocessable_entity }
            end
        end
    end
    
    private
        def todo_params
            params.require(:todo).permit(:task)
        end

        def todo_workers_params
            params.permit(worker_ids:[])
        end

        def set_project
            puts params.inspect
            @project = Project.find_by_id_or_slug(params[:project_slug])
        end

        def set_todo
            # project = Project.find_by_id_or_slug(params[:project_slug])
            @todo = Todo.find_by(project_id: @project.id, id: (params[:todo_id]||params[:id]))
        end
end
