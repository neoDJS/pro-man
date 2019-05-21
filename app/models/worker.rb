class Worker < ApplicationRecord
    has_many :worker_todos
    has_many :todos, through: :worker_todos
    has_many :projects, through: :todos
end
