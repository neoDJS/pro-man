class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  belongs_to :created_by, class_name: "User"
  belongs_to :updated_by, class_name: "User"

  before_validation(on: :create) do
    self.created_by = User.current_user
  ends

  before_validation(on: :update) do
    self.updated_by = User.current_user
  end
end
