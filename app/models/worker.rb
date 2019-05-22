class Worker < ApplicationRecord
    belongs_to :user
    has_many :worker_todos
    has_many :todos, through: :worker_todos
    has_many :projects, through: :todos

    after_initialize :create_user

    def name
        self.user.name
    end

    def create_user
        # user = User.create(name: self.name, email: self.email, password: self.password)
    end
end
