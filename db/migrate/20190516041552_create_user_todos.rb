class CreateUserTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :user_todos do |t|
      t.belongs_to :user
      t.belongs_to :todo
      
      t.timestamps
    end
  end
end
