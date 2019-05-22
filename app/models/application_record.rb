class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  belongs_to :created_by, class_name: "User"
  belongs_to :updated_by, class_name: "User"
  before_validation :set_created_by, on: :create
  before_validation :set_updated_by, on: :update
  # validates_presence_of :created_by, unless: :created_by_id.nil?
  # validates_presence_of :updated_by, unless: :updated_by_id.nil?
  # validates :created_by, allow_nil: true
  # validates :updated_by, allow_nil: true


  def set_created_by
    self.created_by = User.current_user
    self.updated_by = User.current_user
  end

  def set_updated_by
    self.updated_by = User.current_user
  end
end
