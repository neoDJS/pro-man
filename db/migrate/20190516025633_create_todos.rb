class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :task
      t.date :expected_start
      t.date :expected_end
      t.belongs_to :project

      t.timestamps
    end
  end
end
