class Todo < ApplicationRecord
    belongs_to :project
    has_many :worker_todos
    has_many :workers, through: :worker_todos

    def affected_to(user_ids)
        user_ids.each do |id|
            self.user_todos.build(user_id: id)
        end
        self.save
    end
end
