class WorkerTodo < ApplicationRecord
    belongs_to :worker
    belongs_to :todo
    has_many :projects, through: :todo
end
