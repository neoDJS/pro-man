class CreateWorkerTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :worker_todos do |t|
      t.belongs_to :worker
      t.belongs_to :todo
      
      t.belongs_to :created_by, references: :users
      t.belongs_to :updated_by, references: :users
      t.timestamps
    end
  end
end
