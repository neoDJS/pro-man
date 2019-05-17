class Todo < ApplicationRecord
    belongs_to :project
    has_many :user_todos
    has_many :affected_users, class_name: "User", through: :user_todos
end
