class Todo < ApplicationRecord
    belongs_to :project
    has_many :worker_todos
    has_many :workers, through: :worker_todos

    def affected_to(worker_ash)
        worker_ash[:worker_ids].each do |id|
            self.worker_todos.build(worker_id: id)
        end
        self.save
    end
end
