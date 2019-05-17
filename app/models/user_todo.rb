class UserTodo < ApplicationRecord
    belongs_to :user
    belongs_to :todo
    has_many :projects, through: :todo
end
