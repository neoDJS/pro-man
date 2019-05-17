class Project < ApplicationRecord
    belongs_to :created_by, class_name: "User", foreign_key: "user_id"
    has_many :todos
    has_many :affected_users, through: :todos
end
