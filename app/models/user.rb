class User < ApplicationRecord
    has_secure_password
    validates_presence_of :name, :email, :password
    validates :email, uniqueness: true
    has_many :created_projects, class_name: "Project", foreign_key: "user_id"
    has_many :user_todos
    has_many :todos, through: :user_todos
    has_many :projects, through: :todos
  
    def slug
      self.name.gsub(/\W/, '-')
    end
  
    def self.find_by_slug(slugified)
      self.find{|u| u.slug == slugified}
    end
end
