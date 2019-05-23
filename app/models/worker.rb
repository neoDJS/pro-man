class Worker < ApplicationRecord
    belongs_to :user
    has_many :worker_todos
    has_many :todos, through: :worker_todos
    has_many :projects, through: :todos

    def name
        self.user.name
    end

    def user_attributes=(attr)
        self.user = User.find_or_create_by(name: attr[:name])
        self.user.update(attr)
    end
end
